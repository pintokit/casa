def pull_db_seed(url)
  url = URI.parse(url)

  response = Net::HTTP.start(url.host, use_ssl: true) do |http|
    http.get url.request_uri, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A'
  end

  case response
  when Net::HTTPRedirection
    print 'Failed to seed db because the remote server issued a redirect'
  when Net::HTTPSuccess
    data_json = JSON.parse response.body
    response_json = data_json['data']

    return response_json
  else # failed to receive response code 200
    print "#{response.error!}"
  end
end

flats_json = pull_db_seed(ENV['ALL_FLATS_LISTINGS'])

flats_json.each do |f|
  flat = Flat.create!(bed: f['attributes']['bed'], bath: f['attributes']['bath'], stack: f['attributes']['stack'], floor: f['attributes']['floor'], sqft: f['attributes']['sqft'], city_view: f['attributes']['city-view'], is_active: false)

  f['attributes']['listings'].each do |l|
    Listing.create!(flat: flat, price: l['price'], created_at: l['created-at'])
  end
end

floorplans_json = pull_db_seed(ENV['ALL_FLOORPLANS'])

floorplans_json.each do |h|
  floorplan = Floorplan.create!(layout_id: h['attributes']['layout'], windows: h['attributes']['windows'])

  h['attributes']['flats'].each do |f|
    flat = Flat.find_by(floor: f['floor'], stack: f['stack'])
    flat.floorplan = floorplan
    flat.save
  end
end
