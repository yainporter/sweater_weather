require 'rails_helper'

RSpec.describe CurrentWeather, type: :model do
  describe "relationships" do
    it { should belong_to(:forecasts) }
  end
end
