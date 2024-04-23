class YelpService
  def self.conn
    Faraday.new(url: "https://api.yelp.com/") do |faraday|
      faraday.headers["Authorization"] = "Bearer KS7IFxwWZlVQRR_ryycSwBLyayF-js-3Haeqj6X4tswJ9I_9FbRuhob-1nQNeP6E96gtz1AMCPjOcxtbuoLiMgEUFe_8ouUdBNu4DtgsmzyGmGEfKQoDxnHPHOknZnYx"
      faraday.headers["Accept"] = "application/json"
      faraday.request :json
      faraday.response :json, parser_options: { symbolize_names: true }
    end
  end

  def self.get_restaurants(location)
    response = YelpService.conn.get("/v3/businesses/search?location=#{location}&sort_by=best_match&limit=20")
    response.body
  end
end
