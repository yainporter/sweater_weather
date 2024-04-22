class Mapquest
  attr_reader :lat, :lon

  def initialize(data)
    @lat = data[:results].first[:locations].first[:latLng][:lat].to_s
    @lon = data[:results].first[:locations].first[:latLng][:lng].to_s
  end
end
