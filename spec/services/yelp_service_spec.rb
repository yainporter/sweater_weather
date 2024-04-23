require "rails_helper"

RSpec.describe YelpService do
  describe ".conn" do
    it "connects to the yelp api with Faraday", :vcr do
      connection = YelpService.conn
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe ".get_restaurants" do
    it "returns data for a restaurant based on location", :vcr do
      data = YelpService.get_restaurants("Phoenix")

      data_keys = [:businesses, :total, :region]
      business_keys = [
                        :id,
                        :alias,
                        :name,
                        :image_url,
                        :is_closed,
                        :url,
                        :review_count,
                        :categories,
                        :rating,
                        :coordinates,
                        :transactions,
                        :price,
                        :location,
                        :phone,
                        :display_phone,
                        :distance,
                        :attributes]

      expect(data).to be_a(Hash)
      expect(data.keys).to eq(data_keys)
      expect(data[:businesses]).to be_an(Array)
      expect(data[:businesses].count).to eq(20)
      expect(data[:businesses].first.keys).to eq(business_keys)
    end
  end
end
