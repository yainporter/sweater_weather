require "rails_helper"

RSpec.describe OutsideApiService do
  let(:service) { OutsideApiService.new }

  describe ".get_lat_lng" do
    it "gets the latitude and longitude of a valid location", :vcr do
      data = service.get_lat_lng("Phoenix")

      expect(data).to be_a(Hash)
      expect(data[:results].first[:locations].first[:adminArea5]).to eq("Phoenix")
      expect(data[:results].first[:locations].first[:adminArea4]).to eq("Maricopa")
      expect(data[:results].first[:locations].first[:adminArea3]).to eq("AZ")
      expect(data[:results].first[:locations].first[:latLng]).to be_a(Hash)
      expect(data[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)
      expect(data[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
      expect(data[:results].first[:locations].first[:latLng][:lat]).to eq(33.44825)
      expect(data[:results].first[:locations].first[:latLng][:lng]).to eq(-112.0758)
    end
  end

  describe "#weather_conn" do
    it "makes a connection to the weather api" do
      service = OutsideApiService.new
      connection = service.weather_conn

      expect(connection).to be_a(Faraday::Connection)
      expect(connection.url_prefix).to be_a(URI::HTTP)
    end
  end

  describe "#get_weather" do
    let(:lat_lng) { "33.44825,-112.0758" }

    describe "success" do
      it "gets the data from the weather api", :vcr do
        data = service.get_weather(lat_lng)

        expect(data).to be_a(Hash)
      end
    end
  end

  describe "#get_directions" do
    it "gets the data from the mapquest api", :vcr do
      data = service.get_directions("Los Angeles, CA", "New York City, NY")

      expect(data).to be_a(Hash)
      data_keys = [:route, :info]
      route_keys = [
                    :sessionId,
                    :realTime,
                    :distance,
                    :time,
                    :formattedTime,
                    :hasHighway,
                    :hasTollRoad,
                    :hasBridge,
                    :hasSeasonalClosure,
                    :hasTunnel,
                    :hasFerry,
                    :hasUnpaved,
                    :hasTimedRestriction,
                    :hasCountryCross,
                    :legs,
                    :options,
                    :boundingBox,
                    :name,
                    :maxRoutes,
                    :locations,
                    :locationSequence
                  ]
      expect(data.keys).to eq(data_keys)
      expect(data[:route].keys).to eq(route_keys)
    end
  end

  describe "#yelp_conn" do
    it "connects to the yelp api with Faraday", :vcr do
      connection = service.yelp_conn
      expect(connection).to be_a(Faraday::Connection)
    end
  end

  describe "#get_yelp_restaurants" do
    it "returns data for restaurants based on location and category", :vcr do
      data = service.get_yelp_restaurants("Pueblo, CO", "italian")

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

      # If I had more time, I'd test with with some method that iterates over the business array and checks that previous review_count is > current
      expect(data[:businesses].first[:name]).to eq("Brues Alehouse")
      expect(data[:businesses].first[:review_count]).to eq(566)
      expect(data[:businesses].second[:name]).to eq("Bingo Burger")
      expect(data[:businesses].second[:review_count]).to eq(541)
    end
  end
end
