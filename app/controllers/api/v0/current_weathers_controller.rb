class CurrentWeathersController < ApplicationController
  before_action :set_current_weather, only: %i[ show update destroy ]

  # GET /current_weathers
  def index
    @current_weathers = CurrentWeather.all

    render json: @current_weathers
  end

  # GET /current_weathers/1
  def show
    render json: @current_weather
  end

  # POST /current_weathers
  def create
    @current_weather = CurrentWeather.new(current_weather_params)

    if @current_weather.save
      render json: @current_weather, status: :created, location: @current_weather
    else
      render json: @current_weather.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /current_weathers/1
  def update
    if @current_weather.update(current_weather_params)
      render json: @current_weather
    else
      render json: @current_weather.errors, status: :unprocessable_entity
    end
  end

  # DELETE /current_weathers/1
  def destroy
    @current_weather.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_weather
      @current_weather = CurrentWeather.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def current_weather_params
      params.require(:current_weather).permit(:temperature, :feels_like, :humidity, :visibility, :condition, :icon)
    end
end
