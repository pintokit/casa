class PullListingsJob < ApplicationJob
  queue_as :default

  def pull_listings(building, url, bed_type)
    if building['nema']
      url = URI.parse("#{url}#{bed_type}")
    else
      url = URI.parse(url)
    end
    response = Net::HTTP.start(url.host, use_ssl: true) do |http|
      http.get url.request_uri, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A'
    end

    case response
    when Net::HTTPRedirection
      print 'Failed to pull listings because the remote server issued a redirect'
    when Net::HTTPSuccess
      data_json = JSON.parse response.body
      if building['nema']
        units = data_json['units']
        nema_flats(units, bed_type)
      end
    else # failed to receive response code 200
      print "#{response.error!}"
    end
  end

  def nema_flats(units, bed_type)
    Flat.where(bed: bed_type, building: "nema").update_all is_active: false

    units.each do |unit|
      flat = Flat.find_or_create_by!(floor: unit['uf'], stack: unit['un'], sqft: unit['sq'], bath: unit['bathType'], bed: bed_type, building: "nema")
      floorplan = Floorplan.find_or_create_by!(layout_id: unit['fi'])
      current_price = unit['rent'].delete(',').to_i
      last_listing = flat.listings.last

      if flat.listings.empty? || last_listing.price != current_price
        Listing.create!(flat: flat, price: current_price)
      end

      flat.update! is_active: true
      unless flat.floorplan.present?
        flat.update! floorplan: floorplan
      end
    end
  end

  def perform(building, url, bed_type)
    pull_listings(building, url, bed_type)
  end
end
