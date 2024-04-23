class Munchie
  attr_reader :destination_city, :forecast, :restaurant

  def initialize(weather_data, yelp_data)
    @destination_city =
    @forecast =
    @restaurant = yelp_data[:restaurant]
  end
end
