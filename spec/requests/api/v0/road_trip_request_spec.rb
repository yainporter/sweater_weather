require "rails_helper"

RSpec.describe "Road Trip Requests" do
  before do
    @headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
  end

  describe "POST request" do
    describe "success" do
      it "creates a Road Trip", :vcr do
        user = User.create!(email: "test@test.test", password: "test", password_confirmation: "test")
        api_key = user.api_key
        body = {
          "origin": "Cincinatti,OH",
          "destination": "Chicago,IL",
          "api_key": "#{api_key}"
        }

        post "http://localhost:3000/api/v0/road_trip", headers: @headers, params: JSON.generate(body)

        expect(response).to be_successful
        expect(response.status).to eq(201)

        road_trip_data = JSON.parse(response.body, symbolize_names: true)

        data_keys = [:id, :type, :attributes]
        attribute_keys = [:start_city, :end_city, :travel_time, :weather_at_eta]
        weather_keys = [:datetime, :temperature, :condition]

        expect(road_trip_data[:data].keys).to eq(data_keys)
        expect(road_trip_data[:data][:id]).to eq(nil)
        expect(road_trip_data[:data][:type]).to eq("road_trip")
        expect(road_trip_data[:data][:attributes].keys).to eq(attribute_keys)
        expect(road_trip_data[:data][:attributes][:weather_at_eta].keys).to eq(weather_keys)
      end
    end

    describe "error" do
      it "returns 401 if api_key is not provided", :vcr do
        body = {
          "origin": "Cincinatti,OH",
          "destination": "Chicago,IL"
        }

        post "http://localhost:3000/api/v0/road_trip", headers: @headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        road_trip_data = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip_data).to eq({
          errors: [
            {
              :detail=>"Unauthorized",
              :status=>401
            }
          ]
        })
      end

      it "returns 401 if api_key is not correct", :vcr do
        body = {
          "origin": "Cincinatti,OH",
          "destination": "Chicago,IL",
          "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
        }

        post "http://localhost:3000/api/v0/road_trip", headers: @headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        road_trip_data = JSON.parse(response.body, symbolize_names: true)

        expect(road_trip_data).to eq({
          errors: [
            {
              :detail=>"Invalid API key",
              :status=>401
            }
          ]
        })
      end
    end
  end
end
