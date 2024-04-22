require "rails_helper"

RSpec.describe "Forecast Requests" do
  describe "Retrieve weather for a city" do
    describe "success" do
      it "returns json data", :vcr do

        get "http://localhost:3000/api/v0/forecast?location=cincinatti,oh"

        expect(response).to be_successful

        forecast = JSON.parse(response.body, symbolize_names: true)

        data_keys = [:id, :type, :attributes]
        attribute_keys = [:current_weather, :daily_weather, :hourly_weather]

        expect(forecast[:data]).to be_a(Hash)
        expect(forecast[:data].keys).to eq(data_keys)
        expect(forecast[:data][:attributes].keys).to eq(attribute_keys)
        expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)
        expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
        expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)
        expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
        expect(forecast[:data][:attributes][:hourly_weather].count).to eq(24)
      end
    end
  end
end
