require "rails_helper"

RSpec.describe YelpFacade do
  let(:yelp_facade) { YelpFacade.new("Pueblo,CO", "italian")}
  describe "#initialization" do
    it "stores the location and food category" do
      expect(yelp_facade.location).to eq("Pueblo,CO")
      expect(yelp_facade.category).to eq("italian")
      expect(yelp_facade.restaurant_data).to eq(nil)
      expect(yelp_facade.weather_data).to eq(nil)
      expect(yelp_facade.service).to be_an(OutsideApiService)
    end
  end

  describe "#create_munchie" do
    it "creates a munchie poro", :vcr do
      munchie = yelp_facade.create_munchie
      expect(munchie).to be_a(Munchie)
    end
  end

  describe "create_restaurant" do
    it "creates the most reviewed restaurant from the location and type", :vcr do
      restaurant = yelp_facade.create_restaurant
      expect(restaurant).to be_a(Restaurant)
    end
  end

  describe "set_restaurant_data" do
    it "stores the yelp data from the service call", :vcr do
      data_keys = [:businesses, :total, :region]
      business_keys = [
                        :id,
                        :alias,
                        :name,
                        :image_url,
                        :is_closed,
                        :url,
                        :review_count,
                        :categories,
                        :rating,
                        :coordinates,
                        :transactions,
                        :price,
                        :location,
                        :phone,
                        :display_phone,
                        :distance,
                        :attributes]

      yelp_facade.set_restaurant_data
      expect(yelp_facade.restaurant_data).to be_a(Hash)
      expect(yelp_facade.restaurant_data.keys).to eq(data_keys)
      expect(yelp_facade.restaurant_data[:businesses]).to be_an(Array)
      expect(yelp_facade.restaurant_data[:businesses].count).to eq(20)
      expect(yelp_facade.restaurant_data[:businesses].first.keys).to eq(business_keys)
    end
  end

  describe "set_weather_data" do
    it "fetches weather data from the weather API", :vcr do
      yelp_facade.set_weather_data
      data_keys = [:location, :current, :forecast]
      current_weather_keys = [
                              :last_updated_epoch,
                              :last_updated,
                              :temp_c,
                              :temp_f,
                              :is_day,
                              :condition,
                              :wind_mph,
                              :wind_kph,
                              :wind_degree,
                              :wind_dir,
                              :pressure_mb,
                              :pressure_in,
                              :precip_mm,
                              :precip_in,
                              :humidity,
                              :cloud,
                              :feelslike_c,
                              :feelslike_f,
                              :vis_km,
                              :vis_miles,
                              :uv,
                              :gust_mph,
                              :gust_kph
                            ]
      forecastday_keys = [:date, :date_epoch, :day, :astro, :hour]
      expect(yelp_facade.weather_data).to be_a(Hash)
      expect(yelp_facade.weather_data.keys).to eq(data_keys)
      expect(yelp_facade.weather_data[:current].keys).to eq(current_weather_keys)
      expect(yelp_facade.weather_data[:current][:temp_f]).to be_a(Float)
      expect(yelp_facade.weather_data[:forecast][:forecastday].first.keys).to eq(forecastday_keys)
      expect(yelp_facade.weather_data[:forecast][:forecastday].first[:day][:condition][:text]).to be_a(String)
    end
  end
end
