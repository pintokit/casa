class FlatsController < ApplicationController
  before_action :set_flat, only: [:show, :edit, :update, :destroy]

  # GET /flats
  # GET /flats.json
  def index
    @flats = Flat.all
  end

  # GET /flats/1
  # GET /flats/1.json
  def show
  end

  # GET /flats/new
  def new
    @flat = Flat.new
  end

  # GET /flats/1/edit
  def edit
  end

  # POST /flats
  # POST /flats.json
  def create
    @flat = Flat.new(flat_params)

    respond_to do |format|
      if @flat.save
        format.html { redirect_to @flat, notice: 'Flat was successfully created.' }
        format.json { render :show, status: :created, location: @flat }
      else
        format.html { render :new }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flats/1
  # PATCH/PUT /flats/1.json
  def update
    respond_to do |format|
      if @flat.update(flat_params)
        format.html { redirect_to @flat, notice: 'Flat was successfully updated.' }
        format.json { render :show, status: :ok, location: @flat }
      else
        format.html { render :edit }
        format.json { render json: @flat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flats/1
  # DELETE /flats/1.json
  def destroy
    @flat.destroy
    respond_to do |format|
      format.html { redirect_to flats_url, notice: 'Flat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def pull
  # ripped from http://mislav.net/2011/07/faraday-advanced-http/
  url = URI.parse('http://www.rentnema.com/soap-api-4.php?type=0')

  response = Net::HTTP.start(url.host, use_ssl: false) do |http|
    http.get url.request_uri, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A'
  end

  case response
  when Net::HTTPRedirection
    # repeat the request using response['Location']
  when Net::HTTPSuccess
    flats_json = JSON.parse response.body
    Flat.all.each do |flat|
      flat.is_active = false
      flat.save
    end
    @units = flats_json['units']
    @units.each do |unit|
      floorplan = Floorplan.where(layout_id: unit['fi'])
      unless floorplan.count > 0
        floorplan = Floorplan.new(layout_id: unit['fi'])
        floorplan.save
      else
        floorplan = floorplan.first
      end
      flat = Flat.where(floor: unit['uf'], stack: unit['un'])
      unless flat.count > 0
        flat = Flat.new(floor: unit['uf'], stack: unit['un'], sqft: unit['sq'], floorplan_id: floorplan.id, bath: unit['bathType'], bed: 0, is_active: true) # TODO: 0 for now, use real number
        flat.save
      else
        flat = flat.first
        flat.is_active = true
        unless flat.floorplan.present?
          flat.floorplan = floorplan
        end
        flat.save
      end
      current_price = unit['rent'].delete(',').to_i
      history = flat.listings
      last_listing = history.last
      unless history.count > 0 && last_listing[:price] == current_price
        listing = Listing.new(flat_id: flat.id, price: current_price)
        listing.save
      end
    end
    respond_to do |format|
      format.html { redirect_to flats_url, notice: 'Listings pulled successfully.' }
      format.json { flats_json }
    end
  else
    # response code isn't a 200; raise an exception
    response.error!
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat
      @flat = Flat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def flat_params
      params.require(:flat).permit(:bed, :bath, :stack, :floor, :sqft, :is_active, :floorplan_id)
    end
end
