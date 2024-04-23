class OutsideApiFacade
  attr_reader :lat_lng, :current_weather

  def initialize(location = nil, category = nil)
    @service = service
    @lat_lng = nil
    @origin = nil
    @destination = nil
    @location = location
    @category = category
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
    if @lat_lng
      @service.get_weather(@lat_lng)
    elsif @location
        @service.get_weather(@location)
    end
  end

  def create_road_trip(origin, destination)
    set_origin_and_destination(origin, destination)
    RoadTrip.new(road_trip_attributes)
  end

  def travel_time
    find_lat_lng(@destination)
    travel_time = @service.get_directions(@origin, @destination)
    travel_time = travel_time[:route][:formattedTime]
  end

  def set_origin_and_destination(origin, destination)
    @origin = origin
    @destination = destination
  end

  def road_trip_attributes
    {
      start_city: @origin,
      end_city: @destination,
      travel_time: travel_time,
      weather_at_eta: weather_data
    }
  end

  def create_restaurant
    Restaurant.new(restaurant_data)
  end

  def restaurant_data
    @service.get_yelp_restaurants(@location, @category)
  end

  def create_munchie
    Munchie.new(create_restaurant, create_forecast, @location)
  end
end
