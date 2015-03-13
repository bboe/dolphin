class DolphinsController < AuthenticatedController
  def index
    @dolphins = Dolphin.includes(:from, :to).order('created_at desc').limit(16)
    @top_froms = Dolphin.top(by: :from, limit: 8)
    @top_tos = Dolphin.top(by: :to, limit: 8)
  end

  def new
    @dolphin = Dolphin.new
  end

  def create
    from = User.find_by(email: params.require(:dolphin).permit(:from)[:from])
    ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip

    @dolphin = Dolphin.new(from: from, to: current_user, source: ip)
    if @dolphin.save
      redirect_to({action: :index}, notice: 'Dolphin was successfully created.')
    else
      render :new
    end
  end
end
