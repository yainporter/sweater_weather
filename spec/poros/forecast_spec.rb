require "rails_helper"

RSpec.describe Forecast do
  describe "#initialization" do
    let(:facade) { OutsideApiFacade.new }
    let(:lat_lng) { facade.find_lat_lng("Phoenix, AZ") }
    let(:weather_facade_data) { facade.weather_data }

    it "filters data from the service for Forecast", :vcr do
      lat_lng
      weather_facade_data

      current_weather = facade.current_weather
      daily_weather = facade.daily_weather
      hourly_weather = facade.hourly_weather

      forecast = Forecast.new(current_weather, daily_weather, hourly_weather)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(CurrentWeather)
      expect(forecast.daily_weather).to be_an(Array)

      forecast.daily_weather.each do |daily|
        expect(daily).to be_a(DailyWeather)
      end

      expect(forecast.hourly_weather).to be_an(Array)

      forecast.hourly_weather.each do |hourly|
        expect(hourly).to be_an(HourlyWeather)
      end
    end
  end
end
