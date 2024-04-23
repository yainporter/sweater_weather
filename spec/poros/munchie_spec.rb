require "rails_helper"

RSpec.describe Munchie do
  describe "#intialization" do
    it "creates a Munchie Poro from data passed in from OutsideApiService", :vcr do
      facade = OutsideApiFacade.new("Pueblo,CO", "italian")
      restaurant = facade.create_restaurant
      forecast = facade.create_forecast
      munchie = Munchie.new(restaurant, forecast, "Pueblo, CO")

      expect(munchie).to be_a(Munchie)
      expect(munchie.destination_city).to eq("Pueblo, CO")
      expect(munchie.forecast).to eq({
        "summary": "Patchy rain nearby",
        "temperature": 62.1})
      expect(munchie.restaurant).to be_a(Restaurant)
    end
  end
end
