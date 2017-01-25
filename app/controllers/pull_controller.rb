class PullController < ApplicationController

  def studios
    # ripped from http://mislav.net/2011/07/faraday-advanced-http/
    url = URI.parse('http://www.rentnema.com/soap-api-4.php?type=0')

    response = Net::HTTP.start(url.host, use_ssl: false) do |http|
      http.get url.request_uri, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A'
    end

    case response
    when Net::HTTPRedirection
      respond_to do |format|
        format.html { redirect_to listings_url, notice: 'Failed to pull listings because the remote server issued a redirect' }
        format.json { listings_json }
      end
    when Net::HTTPSuccess
      Flat.update_all is_active: false

      flats_json = JSON.parse response.body
      @units = flats_json['units']

      @units.each do |unit|
        flat = Flat.find_or_create_by!(floor: unit['uf'], stack: unit['un'], sqft: unit['sq'], bath: unit['bathType'], bed: 0) # TODO: 0 for now, use real number
        floorplan = Floorplan.find_or_create_by!(layout_id: unit['fi'])
        current_price = unit['rent'].delete(',').to_i
        last_listing = flat.listings.last

        if flat.listings.empty? || last_listing.price =! current_price
          Listing.create(flat: flat, price: current_price)
        end

        flat.update! is_active: true
        unless flat.floorplan.present?
          flat.update! floorplan: floorplan
        end
      end
      respond_to do |format|
        format.html { redirect_to flats_url, notice: 'Listings pulled successfully.' }
        format.json { flats_json }
      end
    else
      # response code isn't a 200; raise an exception
      respond_to do |format|
        format.html { redirect_to listings_url, notice: response.error! }
        format.json { listings_json }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def pull_params
      params.require(:flat).permit(:floorplan, :bed, :bath, :stack, :floor, :sqft, :is_active)
    end
end
