class JsonListingJob < ApplicationJob
  queue_as :default

  def request_flats(hirise, url, bed_type)
    if hirise == :nema
      url = URI.parse("#{url}#{bed_type}")
    end

    response = Net::HTTP.start(url.host, use_ssl: true) do |http|
      http.get url.request_uri, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A'
    end

    case response
    when Net::HTTPRedirection
      print 'Failed to pull listings because the remote server issued a redirect'
    when Net::HTTPSuccess
      data_json = JSON.parse response.body

      if hirise == :nema
        units_json = data_json['units']
        nema_flats(hirise, units_json, bed_type)
      end
      
    else # failed to receive response code 200
      print "#{response.error!}"
    end
  end

  def perform(hirise, url, bed_type)
    request_flats(hirise, url, bed_type)
  end
end
