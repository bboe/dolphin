class DolphinsController < AuthenticatedController
  def index
    load_index_variables params
  end

  def create
    from_email = params.require(:dolphin).permit(:from)[:from]
    if ENV["GOOGLE_CLIENT_DOMAIN"] and !from_email.include?('@')
      from_email += "@#{ENV["GOOGLE_CLIENT_DOMAIN"]}"
    end

    from = User.find_by(email: from_email)
    ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip

    @dolphin = Dolphin.new(from: from, to: current_user, source: ip)
    if @dolphin.save
      redirect_to({action: :index}, notice: 'Dolphin was successfully created.')
    else
      flash[:alert] = @dolphin.errors[:from].first
      @dolphin.from = nil
      load_index_variables
      render :index
    end
  end

  private

  def load_index_variables params={}
    @dolphins = Dolphin.includes(:from, :to)
                       .order('created_at desc')
                       .paginate(page: params[:page], per_page: 8)
    @top_froms = Dolphin.top(by: :from, limit: 8)
    @top_tos = Dolphin.top(by: :to, limit: 8)
  end
end
