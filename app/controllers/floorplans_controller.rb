class FloorplansController < ApplicationController
  before_action :set_floorplan, only: [:show, :edit, :update, :destroy]
  before_action :set_windows, only: [:create, :update]

  # GET /floorplans
  def index
    @floorplans = Floorplan.all
  end

  # GET /floorplans/1
  def show
  end

  # GET /floorplans/new
  def new
    @floorplan = Floorplan.new
  end

  # GET /floorplans/1/edit
  def edit
  end

  # POST /floorplans
  def create
    @floorplan = Floorplan.new(floorplan_params)

    respond_to do |format|
      if @floorplan.save
        format.html { redirect_to @floorplan, notice: 'Floorplan was successfully created.' }
        format.json { render :show, status: :created, location: @floorplan }
      else
        format.html { render :new }
        format.json { render json: @floorplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /floorplans/1
  def update
    respond_to do |format|
      if @floorplan.update(floorplan_params)
        format.html { redirect_to @floorplan, notice: 'Floorplan was successfully updated.' }
        format.json { render :show, status: :ok, location: @floorplan }
      else
        format.html { render :edit }
        format.json { render json: @floorplan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /floorplans/1
  def destroy
    @floorplan.destroy
    respond_to do |format|
      format.html { redirect_to floorplans_url, notice: 'Floorplan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_floorplan
      @floorplan = Floorplan.find(params[:id])
    end

    def set_windows
      unless params[:floorplan][:window1].blank?
        params[:floorplan][:window1] = params[:floorplan][:window1].to_i
      end
      unless params[:floorplan][:window2].blank?
        params[:floorplan][:window2] = params[:floorplan][:window2].to_i
      end
      unless params[:floorplan][:window3].blank?
        params[:floorplan][:window3] = params[:floorplan][:window3].to_i
      end
      unless params[:floorplan][:window4].blank?
        params[:floorplan][:window4] = params[:floorplan][:window4].to_i
      end
      unless params[:floorplan][:window5].blank?
        params[:floorplan][:window5] = params[:floorplan][:window5].to_i
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def floorplan_params
      params.require(:floorplan).permit(:layout_id, :windows, :window1, :window2, :window3, :window4, :window5)
    end
end
