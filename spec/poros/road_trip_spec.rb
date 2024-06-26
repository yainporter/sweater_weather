require "rails_helper"

RSpec.describe RoadTrip do
  let(:facade) { OutsideApiFacade.new({origin: "Cincinatti,OH", destination: "Chicago,IL"})}

  describe "#initialization" do
    it "creates a RoadTrip with data from OutsideApiService", :vcr do
      road_trip_attributes = facade.road_trip_attributes
      roadtrip = RoadTrip.new(road_trip_attributes)
      expect(roadtrip).to be_a(RoadTrip)
      expect(roadtrip.start_city).to eq("Cincinatti,OH")
      expect(roadtrip.end_city).to eq("Chicago,IL")
      expect(roadtrip.travel_time).to eq("04:20:39")
      expect(roadtrip.weather_at_eta).to be_a(Hash)
    end

    it "returns an impossible travel time and empty weather_at_eta when distance is not valid", :vcr do
      facade = OutsideApiFacade.new({origin: "Tokyo", destination: "Chicago,IL"})
      road_trip_attributes = facade.road_trip_attributes
      roadtrip = RoadTrip.new(road_trip_attributes)
      expect(roadtrip.start_city).to eq("Tokyo")
      expect(roadtrip.end_city).to eq("Chicago,IL")
      expect(roadtrip.travel_time).to eq("Impossible")
      expect(roadtrip.weather_at_eta).to be_blank
    end
  end

  describe "#travel_time_in_seconds" do
    it "returns the @travel_time calculated by seconds", :vcr do
      road_trip_attributes = facade.road_trip_attributes
      roadtrip = RoadTrip.new(road_trip_attributes)
      expect(roadtrip.travel_time).to eq("04:20:39")

      hours_into_minutes = 4 * 60
      hours_into_seconds = hours_into_minutes * 60
      minutes_into_seconds = 20 * 60
      seconds = 39 + hours_into_seconds + minutes_into_seconds

      expect(roadtrip.travel_time_in_seconds).to eq(seconds)
    end
  end
    ## Unsure how to test others since they deal with time ##
end
