class DolphinsController < AuthenticatedController
  def index
    @dolphins = Dolphin.all
  end

  def new
    @dolphin = Dolphin.new
  end

  def create
    @dolphin = Dolphin.new(dolphin_params)
    if @dolphin.save
      redirect_to @dolphin, notice: 'Dolphin was successfully created.'
    else
      render :new
    end
  end

  private
    def dolphin_params
      params.require(:dolphin).permit(:from, :to, :source)
    end
end
