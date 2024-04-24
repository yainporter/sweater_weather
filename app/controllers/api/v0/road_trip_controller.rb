class Api::V0::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    if @user
      facade = OutsideApiFacade.new(road_trip_params)
      road_trip = facade.create_road_trip
      render json: RoadTripSerializer.new(road_trip), status: :created
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid API key", 401)).error, status: :unauthorized
    end
  end

  private

  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination)
  end
end
