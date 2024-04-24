class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(params)
    @start_city = params[:start_city]
    @end_city = params[:end_city]
    @travel_time = params[:travel_time]
    @weather_at_eta = find_weather_at_eta(params[:weather_at_eta])
    @arrival_time = time_at_eta
  end

  def find_weather_at_eta(weather_data)
    date = date_at_eta(weather_data)
    hour = hour_at_eta(date)
    {
      datetime: time_at_eta,
      temperature: hour.first[:temp_f],
      condition: hour.first[:condition][:text]
    }
  end

  def date_at_eta(data)
    data[:forecast][:forecastday].select{|date| date[:date] == time_at_eta.split.first}
  end

  def hour_at_eta(date)
    date_and_hour = Time.parse(time_at_eta).strftime("%Y-%m-%d %H:00")
    date.first[:hour].select{|hour| hour[:time].include?(date_and_hour)}
  end

  def time_at_eta
    eta = DateTime.now + travel_time_in_seconds.seconds
    eta.strftime("%Y-%m-%d %H:%M:%S")
  end

  def travel_time_in_seconds
    Time.parse(@travel_time).seconds_since_midnight
  end
end
