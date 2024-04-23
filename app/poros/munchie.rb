class Munchie
  attr_reader :destination_city, :forecast, :restaurant

  def initialize(restaurant, forecast, location)
    @destination_city = location
    @forecast = set_forecast(forecast)
    @restaurant = restaurant
  end

  def set_forecast(forecast)
    {
      "summary": forecast.daily_weather.first.condition,
      "temperature": forecast.current_weather.temperature
    }
  end
end
