class RoadTripSerializer
  include JSONAPI::Serializer
  attributes :start_city, :end_city, :travel_time, :weather_at_eta

  set_id do |atm|
    nil
  end
end
