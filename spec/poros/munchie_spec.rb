require "rails_helper"

RSpec.describe Munchie do
  describe "#intialization" do
    it "creates a Munchie Poro from service data from yelp and weather" do
      munchie = Munchie.new(weather_data, yelp_data)

      expect(munchie).to be_a(Munchie)
      expect(munchie.destination_city).to eq("Pueblo, CO")
      expect(munchie.forecast).to eq({
        "summary": "Cloudy with a chance of meatballs",
        "temperature": "83"})
      expect(munchie.restaurant).to eq({
        "name": "La Forchetta Da Massi",
        "address": "126 S Union Ave, Pueblo, CO 81003",
        "rating": 4.5,
        "reviews": 148})
    end
  end
end
