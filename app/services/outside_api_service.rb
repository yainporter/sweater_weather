class OutsideApiService

  def mapquest_conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials[:map_quest]
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
    end
  end

  def get_lat_lng(location)
      response = mapquest_conn.get("/geocoding/v1/address?location=#{location}")
      response.body
  end

  def weather_conn
    Faraday.new(url: "http://api.weatherapi.com/v1/") do |faraday|
      faraday.params["key"] = Rails.application.credentials[:weather_api]
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
    end
  end

  def get_weather(lat_lng)
    response = weather_conn.get("forecast.json?q=#{lat_lng}")
    response.body
  end
end
