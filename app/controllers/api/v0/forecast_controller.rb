class Api::V0::ForecastController < ApplicationController
  def index
    require 'pry'; binding.pry
    facade = OutsideApiFacade.new(search_params)
    render json: ForecastSerializer.new(facade.create_forecast), status: :ok
  end

  private

  def search_params
    params.permit(:location)
  end
end
