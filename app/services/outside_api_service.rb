class OutsideApiService

  def mapquest_conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials[:map_quest]
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
    end
  end

  def get_lat_lng(location)
    begin
      response = mapquest_conn.get("/geocoding/v1/address?location=#{location}")
      response.body
    rescue Farday::Error => e
      puts e.response[:status]
      puts e.response[:body]
    end
  end
end
