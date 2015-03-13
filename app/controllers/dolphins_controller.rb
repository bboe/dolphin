class DolphinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dolphin, only: [:show, :edit, :update, :destroy]

  # GET /dolphins
  # GET /dolphins.json
  def index
    @dolphins = Dolphin.all
  end

  # GET /dolphins/1
  # GET /dolphins/1.json
  def show
  end

  # GET /dolphins/new
  def new
    @dolphin = Dolphin.new
  end

  # GET /dolphins/1/edit
  def edit
  end

  # POST /dolphins
  # POST /dolphins.json
  def create
    @dolphin = Dolphin.new(dolphin_params)

    respond_to do |format|
      if @dolphin.save
        format.html { redirect_to @dolphin, notice: 'Dolphin was successfully created.' }
        format.json { render :show, status: :created, location: @dolphin }
      else
        format.html { render :new }
        format.json { render json: @dolphin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dolphins/1
  # PATCH/PUT /dolphins/1.json
  def update
    respond_to do |format|
      if @dolphin.update(dolphin_params)
        format.html { redirect_to @dolphin, notice: 'Dolphin was successfully updated.' }
        format.json { render :show, status: :ok, location: @dolphin }
      else
        format.html { render :edit }
        format.json { render json: @dolphin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dolphins/1
  # DELETE /dolphins/1.json
  def destroy
    @dolphin.destroy
    respond_to do |format|
      format.html { redirect_to dolphins_url, notice: 'Dolphin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dolphin
      @dolphin = Dolphin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dolphin_params
      params.require(:dolphin).permit(:from, :to, :source)
    end
end
