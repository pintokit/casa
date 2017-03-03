class FloorplansController < ApplicationController
  before_action :set_floorplan, only: [:show, :edit, :update, :destroy]
  before_action :set_window_symbols
  before_action :set_windows, only: [:create, :update]

  # GET /floorplans
  def index
    @floorplans = Floorplan.all
  end

  # GET /floorplans/1
  def show
    @flats = @floorplan.flats
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
    def set_window_symbols
      @window_symbols = [:window1, :window2, :window3, :window4, :window5]
    end

    def set_floorplan
      @floorplan = Floorplan.find(params[:id])
    end

    def set_windows
      @window_symbols.each do |window|
        unless params[:floorplan][window].blank?
          params[:floorplan][window] = params[:floorplan][window].to_i
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def floorplan_params
      params.require(:floorplan).permit(:layout_id, :windows, :window1, :window2, :window3, :window4, :window5)
    end
end
