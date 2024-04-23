class RoadTrip
  attr_reader :start_city, :end_city, :travel_time

  def initialize(params)
    require 'pry'; binding.pry
    @start_city = params[:start_city]
    @end_city = params[:start_city]
    @travel_time = params[:travel_time]
    @weather_at_eta = weather_at_eta(params[:weather_at_eta])
  end

  def weather_at_eta(data)
    arrival_time = find_eta.strftime("%Y-%m-%d %H:%M:%S")
    date = data[:forecast][:forecastday].select{|date| date[:date] == arrival_time.split.first}
    hour = date.first[:hour].select{|hour| hour[:time].include?(find_eta.strftime("%Y-%m-%d %H"))}
    require 'pry'; binding.pry
    {
      datetime: arrival_time,
      temperature: hour.first[:temp_f],
      condition: hour.first[:condition][:text]
    }
  end

  def find_eta
    current_time = DateTime.now
    number_of_seconds = Time.parse(@travel_time).seconds_since_midnight
    current_time + number_of_seconds.seconds
  end

  def round_eta
    find_eta
  end
end
