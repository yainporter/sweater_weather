require "rails_helper"

RSpec.describe OutsideApiFacade do
  let(:facade) { OutsideApiFacade.new }
  let(:lat_lng) { facade.find_lat_lng("Phoenix, AZ") }

  describe "#find_lat_lng" do
    it "finds the lat and lng of a location", :vcr do
      expect(lat_lng).to be_a(String)
      expect(lat_lng).to eq("33.44825,-112.0758")
    end

    it "stores the lat_lng in @lat_lng", :vcr do
      lat_lng
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

    describe "error" do
      it "returns an error message when no lat and lng are passed", :vcr do
        weather_facade_data = facade.weather_data

        expect(weather_facade_data).to be_a(Hash)
        expect(weather_facade_data).to eq({:error=>{:code=>1003, :message=>"Parameter q is missing."}})
      end
    end
  end

  let(:weather_facade_data) { facade.weather_data }

  describe "daily_weather" do
    describe "success" do
      it "creates an array of DailyWeather from #weather_data", :vcr do
        lat_lng
        weather_facade_data

        daily_weather = facade.daily_weather
        expect(daily_weather).to be_an(Array)
        daily_weather.each do |weather|
          expect(weather).to be_a(DailyWeather)
        end
      end
    end

    describe "error" do
      it "returns an error message when no lat and lng are passed", :vcr do
        daily_weather = facade.daily_weather
        expect(daily_weather).to eq("Parameter q is missing.")
      end
    end
  end

  describe "current_weather" do
    describe "success" do
      it "creates CurrentWeather from #weather_data", :vcr do
        lat_lng
        weather_facade_data
        current_weather = facade.current_weather

        expect(current_weather).to be_a(CurrentWeather)
      end
    end

    describe "error" do
      it "returns an error message when no lat and lng are passed", :vcr do
        current_weather = facade.current_weather

        expect(current_weather).to eq("Parameter q is missing.")
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

    describe "error" do
      it "returns an error message when no lat and lng are passed", :vcr do
        hourly_weather = facade.hourly_weather

        expect(hourly_weather).to eq("Parameter q is missing.")
      end
    end
  end

  describe "#forecast" do
    describe "success" do
      it "creates a Forecast poro with information from CurrentWeather, DailyWeather, and HourlyWeather", :vcr do
        lat_lng
        weather_facade_data

        forecast = facade.create_forecast

        expect(forecast).to be_a(Forecast)
      end
    end

    describe "error" do
      it "returns an error message when there is no location", :vcr do
        forecast = facade.create_forecast

        expect(forecast).to_not be_a(Forecast)
        expect(forecast).to eq("Location parameters are missing")
      end
    end
  end
end
