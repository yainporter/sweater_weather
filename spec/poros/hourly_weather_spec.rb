require "rails_helper"

RSpec.describe HourlyWeather do
  describe "initialization" do
    it "creates an HourlyWeather poro from the weather API data" do
      data = {
        time: "2024-04-22 00:00",
        temp_f: 85.5,
        condition: {
            text: "Clear ",
            icon: "//cdn.weatherapi.com/weather/64x64/night/113.png",
        }
      }

      hourly_weather = HourlyWeather.new(data)
      expect(hourly_weather).to be_an(HourlyWeather)
      expect(hourly_weather.time).to eq("2024-04-22 00:00")
      expect(hourly_weather.temperature).to eq(85.5)
      expect(hourly_weather.condition).to eq("Clear ")
      expect(hourly_weather.icon).to eq("//cdn.weatherapi.com/weather/64x64/night/113.png")
    end
  end
end
