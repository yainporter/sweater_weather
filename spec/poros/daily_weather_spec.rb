require "rails_helper"

RSpec.describe DailyWeather do
  describe "initialization" do
    it "creates a DailyWeather poro from the weather API data" do
      data = {
                date: "2024-04-22",
                day: {
                  maxtemp_f: 94.6,
                  mintemp_f: 76.2,
                  condition: {
                      text: "Sunny",
                      icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                  },
                  uv: 9.0
                },
                astro: {
                  sunrise: "05:49 AM",
                  sunset: "07:05 PM",
                }
              }

        daily_weather = DailyWeather.new(data)

        expect(daily_weather).to be_a(DailyWeather)
        expect(daily_weather.date).to be_a(String)
        expect(daily_weather.sunrise).to be_a(String)
        expect(daily_weather.sunset).to be_a(String)
        expect(daily_weather.max_temp).to be_a(Float)
        expect(daily_weather.min_temp).to be_a(Float)
        expect(daily_weather.condition).to be_a(String)
        expect(daily_weather.icon).to be_a(String)
    end
  end
end
