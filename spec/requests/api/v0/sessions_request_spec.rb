require "rails_helper"

RSpec.describe "Sessions Requests" do
  before do
    @headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
  end
  describe "POST" do
    it "returns 200 on successful request", :vcr do
      User.create!({email: "test@test.test", password: "testing", password_confirmation: "testing"})

      post "http://localhost:3000/api/v0/sessions", headers: @headers, params: JSON.generate({
        "email": "test@test.test",
        "password": "testing"
      })

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      data_keys = [:id, :type, :attributes]
      attribute_keys = [:email, :api_key]
      expect(data[:data].keys).to eq(data_keys)
      expect(data[:data][:type]).to eq("user")
      expect(data[:data][:attributes].keys).to eq(attribute_keys)
    end
  end
end
