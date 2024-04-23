class MunchieSerializer
  include JSONAPI::Serializer
  attributes :destination_city, :forecast, :restaurant

  set_id do |atm|
    nil
  end
end
