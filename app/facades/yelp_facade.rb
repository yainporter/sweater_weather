class YelpFacade < OutsideApiFacade
  attr_reader :location, :category, :restaurant_data, :weather_data, :service

  def initialize(location, category)
    @service = OutsideApiService.new
    @location = location
    @category = category
    @restaurant_data = nil
    @weather_data = nil
  end

  def set_restaurant_data
    @restaurant_data = @service.get_yelp_restaurants(@location, @category)
  end

  def set_weather_data
    @weather_data = @service.get_weather(@location)
  end

  def create_restaurant
    Restaurant.new(set_restaurant_data)
  end

  def create_munchie
    Munchie.new(create_restaurant, create_weather)
  end
end
