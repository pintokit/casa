class FloorplansController < ApplicationController
  before_action :set_floorplan, only: [:show, :edit, :update, :destroy]

  # GET /floorplans
  def index
    @floorplans = Floorplan.all.order(:layout_id)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def floorplan_params
      params.require(:floorplan).permit(:layout_id, :windows, :consecutive_windows, :total_windows)
    end
end
