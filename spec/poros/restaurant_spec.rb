require "rails_helper"

RSpec.describe Restaurant do
  describe "initialization " do
    it "filters restaurant data" do
      restaurant_data

      restaurant = Restaurant.new(restaurant_data)
      expect(restaurant.name).to eq("La Forchetta Da Massi")
      expect(restaurant.address).to eq("126 S Union Ave, Pueblo, CO 81003")
      expect(restaurant.rating).to eq(4.5)
      expect(restaurant.reviews).to eq(148)
    end
  end
end
