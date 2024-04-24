class Api::V0::RoadTripController < ApplicationController
  def create
    facade = OutsideApiFacade.new(road_trip_params)
    render json: RoadTripSerializer.new(facade), status: :created
  end

  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination)
  end
end
