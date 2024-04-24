require "rails_helper"

RSpec.describe CurrentWeather do
  describe "initialization" do
    it "creates an CurrentWeather poro from the weather API data" do
      data = {
        current: {
          last_updated: "2024-04-22 08:45",
          temp_f: 77.0,
          condition: {
            text: "Sunny",
            icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
          },
          humidity: 19,
          feelslike_f: 74.8,
          vis_miles: 9.0,
          uv: 7.0
        }
      }


      current_weather = CurrentWeather.new(data)

      expect(current_weather).to be_a(CurrentWeather)
      expect(current_weather.last_updated).to eq("2024-04-22 08:45")
      expect(current_weather.temperature).to eq(77.0)
      expect(current_weather.feels_like).to eq(74.8)
      expect(current_weather.humidity).to eq(19)
      expect(current_weather.uvi).to eq(7.0)
      expect(current_weather.visibility).to eq(9.0)
      expect(current_weather.condition).to eq("Sunny")
      expect(current_weather.icon).to eq("//cdn.weatherapi.com/weather/64x64/day/113.png")
    end
  end
end
