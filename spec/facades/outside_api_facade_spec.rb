require "rails_helper"

RSpec.describe OutsideApiFacade do
  describe "#create_mapquest" do
    let(:facade) { OutsideApiFacade.new }
    it "creates a mapquest poro with service data", :vcr do

      expect(facade.create_mapquest("Phoenix, AZ")).to be_a(Mapquest)
    end
  end
end
