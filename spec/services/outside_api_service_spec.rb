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
end
