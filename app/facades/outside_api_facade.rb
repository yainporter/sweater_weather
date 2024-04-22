class OutsideApiFacade
  attr_reader :lat_lng, :current_weather

  def initialize
    @service = service
    @lat_lng = nil
  end

  def service
    @service ||= OutsideApiService.new
  end

  def find_lat_lng(location)
    data = @service.get_lat_lng(location)
    latlng = data[:results].first[:locations].first[:latLng]
    @lat_lng = "#{latlng[:lat]},#{latlng[:lng]}"
  end

  def create_forecast
    Forecast.new(current_weather, daily_weather, hourly_weather)
  end

  def current_weather
    CurrentWeather.new(weather_data[:current])
  end

  def daily_weather
    weather_data[:forecast][:forecastday].map do |daily_weather_data|
      DailyWeather.new(daily_weather_data)
    end
  end

  def hourly_weather
    weather_data[:forecast][:forecastday].first[:hour].map do |hourly_data|
      HourlyWeather.new(hourly_data)
    end
  end

  def weather_data
    @service.get_weather(@lat_lng)
  end
end
