class HourlyWeathersController < ApplicationController
  before_action :set_hourly_weather, only: %i[ show update destroy ]

  # GET /hourly_weathers
  def index
    @hourly_weathers = HourlyWeather.all

    render json: @hourly_weathers
  end

  # GET /hourly_weathers/1
  def show
    render json: @hourly_weather
  end

  # POST /hourly_weathers
  def create
    @hourly_weather = HourlyWeather.new(hourly_weather_params)

    if @hourly_weather.save
      render json: @hourly_weather, status: :created, location: @hourly_weather
    else
      render json: @hourly_weather.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hourly_weathers/1
  def update
    if @hourly_weather.update(hourly_weather_params)
      render json: @hourly_weather
    else
      render json: @hourly_weather.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hourly_weathers/1
  def destroy
    @hourly_weather.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hourly_weather
      @hourly_weather = HourlyWeather.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hourly_weather_params
      params.require(:hourly_weather).permit(:time, :temperature, :conditions, :icon)
    end
end
