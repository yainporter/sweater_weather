require "rails_helper"

RSpec.describe OutsideApiService do
  describe ".get_lat_lng" do
    let(:service) { OutsideApiService.new }

    it "gets the latitude and longitude of a valid location", :vcr do
      data = service.get_lat_lng("Phoenix")

      expect(data[:results].first[:locations].first[:adminArea5]).to eq("Phoenix")
      expect(data[:results].first[:locations].first[:adminArea4]).to eq("Maricopa")
      expect(data[:results].first[:locations].first[:adminArea3]).to eq("AZ")
      expect(data[:results].first[:locations].first[:latLng]).to be_a(Hash)
      expect(data[:results].first[:locations].first[:latLng][:lat]).to be_a(Float)
      expect(data[:results].first[:locations].first[:latLng][:lng]).to be_a(Float)
      expect(data[:results].first[:locations].first[:latLng][:lat]).to eq(33.44825)
      expect(data[:results].first[:locations].first[:latLng][:lng]).to eq(-112.0758)
    end
  end
end
