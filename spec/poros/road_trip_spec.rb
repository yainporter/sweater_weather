require "rails_helper"

RSpec.describe RoadTrip do
  describe "#initialization" do
    it "creates a RoadTrip with data from OutsideApiService" do
      roadtrip = RoadTrip.new()

      expect(roadtrip).to be_a(RoadTrip)
      expect(roadtrip.start_city).to eq()
      expect(roadtrip.end_city).to eq()
      expect(roadtrip.travel_time).to eq()
      expect(roadtrip.weather_at_eta).to be_a(Hash)
    end
  end

  describe "#weather_at_eta" do
    it "calculates the weather at time of arrival" do
      
    end
  end
end
