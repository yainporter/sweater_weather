class OutsideApiService

  def mapquest_conn
    Faraday.new(url: "https://www.mapquestapi.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials[:map_quest]
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
    end
  end

  def weather_conn
    Faraday.new(url: "http://api.weatherapi.com/v1/") do |faraday|
      faraday.params["key"] = Rails.application.credentials[:weather_api]
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
    end
  end

  def yelp_conn
    Faraday.new(url: "https://api.yelp.com/") do |faraday|
      faraday.headers["Authorization"] = "Bearer KS7IFxwWZlVQRR_ryycSwBLyayF-js-3Haeqj6X4tswJ9I_9FbRuhob-1nQNeP6E96gtz1AMCPjOcxtbuoLiMgEUFe_8ouUdBNu4DtgsmzyGmGEfKQoDxnHPHOknZnYx"
      faraday.headers["Accept"] = "application/json"
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
    end
  end

  def get_yelp_restaurants(location)
    response = yelp_conn.get("/v3/businesses/search?location=#{location}&sort_by=best_match&limit=20")
    response.body
  end

  def get_lat_lng(location)
      response = mapquest_conn.get("/geocoding/v1/address?location=#{location}")
      response.body
  end


  def get_weather(lat_lng)
    response = weather_conn.get("forecast.json?q=#{lat_lng}&days=5")
    response.body
  end

  def get_directions(from, to)
    response = mapquest_conn.get("/directions/v2/route?from=#{from}&to=#{to}")
    response.body
  end
end
