class Api::V1::MunchiesController < ApplicationController
  def index
    facade = OutsideApiFacade.new(params[:destination], params[:food])
    render json: MunchieSerializer.new(facade.create_munchie), status: :ok
  end
end
