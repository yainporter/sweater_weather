class Munchie
  attr_reader :destination_city, :forecast, :restaurant

  def initialize(weather_data, yelp_data)
    require 'pry'; binding.pry
    @destination_city =
    @forecast =
    @restaurant = yelp_data[:restaurant]
  end
end
