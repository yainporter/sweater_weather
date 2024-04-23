require "rails_helper"

RSpec.describe "Munchies Requests" do
  before do
    @headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
  end

  describe "GET" do
    describe "success" do
      it "returns 200 status and data", :vcr do
        get "/api/v1/munchies?destination=pueblo,co&food=italian"

        expect(response).to be_successful
        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)
        data_keys = [:id, :type, :attributes]
        forecast_keys = [:summary, :temperature]
        restaurant_keys = [:name, :address, :rating, :reviews]
        attribute_keys = [:destination_city, :forecast, :restaurant]
        expect(data[:data].keys).to eq(data_keys)
        expect(data[:data][:type]).to eq("munchie")
        expect(data[:data][:attributes].keys).to eq(attribute_keys)
        expect(data[:data][:attributes][:forecast].keys).to eq(forecast_keys)
        expect(data[:data][:attributes][:restaurant].keys).to eq(restaurant_keys)
        expect(data).to eq({
                            "data": {
                              "id": nil,
                              "type": "munchie",
                              "attributes": {
                                "destination_city": "pueblo,co",
                                "forecast": {
                                  "summary": "Patchy rain nearby",
                                  "temperature": 62.1
                                  },
                                "restaurant": {
                                  "name": "Brues Alehouse",
                                  "address": "120 Riverwalk Pl, Pueblo, CO 81003",
                                  "rating": 4.0,
                                  "reviews": 566
                                }
                              }
                            }
                          })
      end
    end

    describe "failure" do
      it "returns 400 when no parameters are passed", :vcr do
        get "/api/v1/munchies"

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:errors].first[:detail]).to eq("Missing parameters, try again.")
      end

      it "returns 400 when no location is passed", :vcr do
        get "/api/v1/munchies?food=italian"

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:errors].first[:detail]).to eq("Missing parameters, try again.")
      end
    end
  end
end
