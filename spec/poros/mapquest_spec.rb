require "rails_helper"

RSpec.describe Mapquest do
  describe "#initialization" do
    it "filters the data from the service for Mapquest", :vcr do
      data = {
        results: [{
          locations: [{
            latLng: {
              lat: 33.44825,
              lng: -112.0758
            }
          }]
        }]
      }
      phoenix = Mapquest.new(data)

      expect(phoenix.lat).to eq("33.44825")
      expect(phoenix.lon).to eq("-112.0758")
    end
  end
end
