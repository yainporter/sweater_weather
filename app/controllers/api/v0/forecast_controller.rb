class Api::V0::ForecastController < ApplicationController
  def index
    find_lat_lng
    render json: ForecastSerializer.new(@facade.create_forecast), status: :ok
  end

  private

  def facade
    @facade ||= OutsideApiFacade.new
  end

  def find_lat_lng
    facade.find_lat_lng(params[:location])
  end
end
