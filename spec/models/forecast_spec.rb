require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe "relationships" do
    it { should have_many(:current_weathers) }
    it { should have_many(:daily_weathers) }
    it { should have_many(:hourly_weathers) }
  end
end
