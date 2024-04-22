class DailyWeathersController < ApplicationController
  before_action :set_daily_weather, only: %i[ show update destroy ]

  # GET /daily_weathers
  def index
    @daily_weathers = DailyWeather.all

    render json: @daily_weathers
  end

  # GET /daily_weathers/1
  def show
    render json: @daily_weather
  end

  # POST /daily_weathers
  def create
    @daily_weather = DailyWeather.new(daily_weather_params)

    if @daily_weather.save
      render json: @daily_weather, status: :created, location: @daily_weather
    else
      render json: @daily_weather.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /daily_weathers/1
  def update
    if @daily_weather.update(daily_weather_params)
      render json: @daily_weather
    else
      render json: @daily_weather.errors, status: :unprocessable_entity
    end
  end

  # DELETE /daily_weathers/1
  def destroy
    @daily_weather.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_weather
      @daily_weather = DailyWeather.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def daily_weather_params
      params.require(:daily_weather).permit(:date, :sunrise, :sunset, :max_temp, :min_temp, :condition, :icon)
    end
end
