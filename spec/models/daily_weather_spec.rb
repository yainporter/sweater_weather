require 'rails_helper'

RSpec.describe DailyWeather, type: :model do
  describe "relationships" do
    it { should belong_to(:forecasts) }
  end
end
