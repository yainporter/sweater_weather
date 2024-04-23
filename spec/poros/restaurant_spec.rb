require "rails_helper"

RSpec.describe Restaurant do
  describe "initialization " do
    it "filters restaurant data", :vcr do
      service = OutsideApiService.new
      restaurant = Restaurant.new(service.get_yelp_restaurants("Pueblo, Co", "italian"))
      expect(restaurant.name).to eq("Brues Alehouse")
      expect(restaurant.address).to eq("120 Riverwalk Pl, Pueblo, CO 81003")
      expect(restaurant.rating).to eq(4.0)
      expect(restaurant.reviews).to eq(566)
    end
  end
end
