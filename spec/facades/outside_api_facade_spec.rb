require "rails_helper"

RSpec.describe OutsideApiFacade do
  let(:facade) { OutsideApiFacade.new({location: "Phoenix, AZ"}) }
  let(:lat_lng) { facade.find_lat_lng }

  describe "#find_lat_lng" do
    it "returns the service data of #get_lat_lng", :vcr do
      expect(lat_lng).to be_a(Hash)
      expect(lat_lng[:results].first[:locations].first[:latLng]).to be_a(Hash)
    end
  end

  describe "#set_lat_lng" do
    it "stores the lat_lng from the service in @lat_lng", :vcr do
      lat_lng = facade.set_lat_lng
      expect(facade.lat_lng).to eq(lat_lng)
    end
  end

  describe "#weather_data" do
    describe "success" do
      it "stores data in the @data attribute", :vcr do
        lat_lng

        weather_facade_data = facade.weather_data
        expect(weather_facade_data).to be_a(Hash)
        expect(weather_facade_data).to eq(facade.weather_data)
      end
    end
  end

  let(:weather_facade_data) { facade.weather_data }

  describe "daily_weather" do
    describe "success" do
      it "creates an array of DailyWeather from #weather_data", :vcr do
        weather_facade_data

        daily_weather = facade.daily_weather
        expect(daily_weather).to be_an(Array)
        daily_weather.each do |weather|
          expect(weather).to be_a(DailyWeather)
        end
      end
    end
  end

  describe "current_weather" do
    describe "success" do
      it "creates CurrentWeather from @weather_data", :vcr do
        current_weather = facade.current_weather

        expect(current_weather).to be_a(CurrentWeather)
      end
    end
  end

  describe "hourly_weather" do
    describe "success" do
      it "creates an array of 24 HourlyWeather from #weather_data", :vcr do
        lat_lng
        weather_facade_data
        hourly_weather = facade.hourly_weather

        expect(hourly_weather).to be_an(Array)
        expect(hourly_weather.count).to eq(24)

        hourly_weather.each do |hour|
          expect(hour).to be_a(HourlyWeather)
        end
      end
    end
  end

  describe "#forecast" do
    describe "success" do
      it "creates a Forecast poro with information from CurrentWeather, DailyWeather, and HourlyWeather", :vcr do
        forecast = facade.create_forecast

        expect(forecast).to be_a(Forecast)
      end
    end
  end

  describe "End Point - 4" do
    let(:road_trip_facade){ OutsideApiFacade.new({ origin: "Cincinatti,OH", destination: "Chicago, IL"}) }
    describe "#travel_time" do
      it "calculates the travel time with the mapquest API", :vcr do
        travel_time = road_trip_facade.travel_time

        expect(travel_time).to eq("04:20:39")
      end
    end

    describe "#create_roadtrip" do
      it "creates a roadtrip", :vcr do
        roadtrip = road_trip_facade.create_road_trip
        expect(roadtrip).to be_a(RoadTrip)
      end
    end
  end
end
