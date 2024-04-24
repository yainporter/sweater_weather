class Api::V0::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    if @user
      facade = OutsideApiFacade.new(road_trip_params)
      road_trip = facade.create_road_trip
      render json: RoadTripSerializer.new(road_trip), status: :created
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid API key", 401)), status: :unauthorized
    end
  end

  private

  def road_trip_params
    params.require(:road_trip).permit(:origin, :destination)
  end

  def authenticate_api_key
    begin
      api_key = params[:api_key]
      hashed_key = Digest::SHA256.hexdigest(api_key)
      @user = User.find_by(api_key_hash: hashed_key)
    rescue TypeError
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
