require "rails_helper"

RSpec.describe OutsideApiService do
  describe ".get_lat_lng" do
    let(:service) { OutsideApiService.new }

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
    let(:service) { OutsideApiService.new }
    let(:lat_lng) { "33.44825,-112.0758" }

    describe "success" do
      it "gets the data from the weather api", :vcr do
        data = service.get_weather(lat_lng)

        expect(data).to be_a(Hash)
      end
    end
  end
      # expect(data[:location][:name]).to eq("Phoenix")
    # expect(data[:current][:last_updated]).to eq("2024-04-22 08:45")
      # expect(data[:current][:temp_f]).to eq(77.0)
      # expect(data[:current][:feelslike_f]).to eq(74.8)
      # expect(data[:current][:humidity]).to eq(19)
      # expect(data[:current][:uv]).to eq(7.0)
      # expect(data[:current][:vis_miles]).to eq(9.0)
      # expect(data[:current][:condition][:text]).to eq("Sunny")
      # expect(data[:current][:condition][:icon]).to eq("//cdn.weatherapi.com/weather/64x64/day/113.png")
      # expect(data[:forecast][:forecastday]).to be_an(Array)
      # expect(data[:forecast][:forecastday].first).to be_an(Array)
end
