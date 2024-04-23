class Api::V0::RoadTripController < ApplicationController
  def create
    @facade.road_trip_weather(params[:origin], params[:destination])
    
  end

  def facade
    @facade ||= OutsideApiFacade.new
  end
end
