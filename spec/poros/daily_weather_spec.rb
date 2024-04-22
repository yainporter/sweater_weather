require "rails_helper"

RSpec.describe DailyWeather do
  describe "initialization" do
    it "creates a DailyWeather poro from the weather API data" do
      data = {
        # forecast: {
        #     forecastday: [
        #         {
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
                # },
                # {
                #   date: "2024-04-23",
                #   day: {
                #       maxtemp_f: 92.9,
                #       mintemp_f: 75.0,
                #       condition: {
                #           text: "Sunny",
                #           icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                #       },
                #       uv: 10.0
                #   },
                #   astro: {
                #       sunrise: "05:48 AM",
                #       sunset: "07:06 PM",
                #   },
                # },
                # {
                #   date: "2024-04-24",
                #   day: {
                #       maxtemp_f: 88.0,
                #       mintemp_f: 73.2,
                #       condition: {
                #           text: "Sunny",
                #           icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                #       },
                #       uv: 10.0
                #   },
                #   astro: {
                #       sunrise: "05:47 AM",
                #       sunset: "07:06 PM",
                #   },
                # },
                # {
                #   date: "2024-04-25",
                #   day: {
                #       maxtemp_f: 79.6,
                #       mintemp_f: 66.9,
                #       condition: {
                #           text: "Sunny",
                #           icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                #       },
                #       uv: 6.0
                #   },
                #   astro: {
                #       sunrise: "05:46 AM",
                #       sunset: "07:07 PM",
                #   },
                #   uv: 6.0
                # },
                # date: "2024-04-26",
                # day: {
                #     maxtemp_f: 83.6,
                #     mintemp_f: 66.6,
                #     condition: {
                #         text: "Sunny",
                #         icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                #     },
                #     uv: 6.0
                # },
                # astro: {
                #     sunrise: "05:45 AM",
                #     sunset: "07:08 PM",
                # }
        #       ]
        #   }
        # }

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
