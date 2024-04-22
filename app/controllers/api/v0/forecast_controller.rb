class Api::V0::ForecastController < ApplicationController
  rescue_from NoMethodError, with: :no_method_error


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

  def no_method_error(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .no_method_error, status: :bad_request
  end
end
