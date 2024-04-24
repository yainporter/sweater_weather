class CurrentWeather
  attr_reader :last_updated,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :condition,
              :icon

  def initialize(data)
    @last_updated = data[:current][:last_updated]
    @temperature = data[:current][:temp_f]
    @feels_like = data[:current][:feelslike_f]
    @humidity = data[:current][:humidity]
    @uvi = data[:current][:uv]
    @visibility = data[:current][:vis_miles]
    @condition = data[:current][:condition][:text]
    @icon = data[:current][:condition][:icon]
  end
end
