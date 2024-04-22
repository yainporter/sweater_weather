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
    if weather_data[:error].present?
      "Location parameters are missing"
    else
      Forecast.new(current_weather, daily_weather, hourly_weather)
    end
  end

  def current_weather
    begin
      CurrentWeather.new(weather_data[:current])
    rescue NoMethodError
      weather_data[:error][:message]
    end
  end

  def daily_weather
    begin
      weather_data[:forecast][:forecastday].map do |daily_weather_data|
        DailyWeather.new(daily_weather_data)
      end
    rescue NoMethodError
      weather_data[:error][:message]
    end
  end

  def hourly_weather
    begin
      weather_data[:forecast][:forecastday].first[:hour].map do |hourly_data|
        HourlyWeather.new(hourly_data)
      end
    rescue NoMethodError
      weather_data[:error][:message]
    end
  end

  def weather_data
    @service.get_weather(@lat_lng)
  end
end
