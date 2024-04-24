class OutsideApiFacade
  attr_reader :lat_lng, :current_weather

  def initialize(params)
    @service = OutsideApiService.new
    @location = params[:location]
    @origin = params[:origin]
    @destination = params[:destination]
    @lat_lng = nil
    @weather_data = weather_data
  end

  def set_lat_lng
    data = find_lat_lng
    latlng = data[:results].first[:locations].first[:latLng]
    @lat_lng = "#{latlng[:lat]},#{latlng[:lng]}"
  end

  def create_forecast
    Forecast.new(current_weather, daily_weather, hourly_weather)
  end

  def current_weather
    CurrentWeather.new(@weather_data)
  end

  def daily_weather
    @weather_data[:forecast][:forecastday].map do |daily_weather_data|
      DailyWeather.new(daily_weather_data)
    end
  end

  def hourly_weather
    @weather_data[:forecast][:forecastday].first[:hour].map do |hourly_data|
      HourlyWeather.new(hourly_data)
    end
  end

  def weather_data
    if @lat_lng
      @weather_data = @service.get_weather(@lat_lng)
    elsif @location
      @weather_data = @service.get_weather(@location)
    end
  end

  def create_road_trip
    set_lat_lng
    RoadTrip.new(road_trip_attributes)
  end

  def travel_time
    travel_time = @service.get_directions(@origin, @destination)
    travel_time = travel_time[:route][:formattedTime]
  end

  def find_lat_lng
    if @location
      @service.get_lat_lng(@location)
    else
      @service.get_lat_lng(@destination)
    end
  end

  def road_trip_attributes
    {
      start_city: @origin,
      end_city: @destination,
      travel_time: travel_time,
      weather_at_eta: weather_data
    }
  end
end
