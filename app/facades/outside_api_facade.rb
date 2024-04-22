class OutsideApiFacade
  def initialize
    @service = OutsideApiService.new
  end

  def create_mapquest(location)
    data = @service.get_lat_lng(location)
    Mapquest.new(data)
  end
end
