require "rails_helper"

RSpec.describe "Users Requests" do
  before do
    @headers = {"CONTENT_TYPE" => "application/json", "Accept" => "application/json"}
  end
  describe "POST" do
    describe "success" do
      it "creates a new User", :vcr do
        expect(User.count).to eq(0)

        post "http://localhost:3000/api/v0/users", headers: @headers, params: JSON.generate({
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        })

        expect(response).to be_successful
        expect(response.status).to eq(201)

        user_data = JSON.parse(response.body, symbolize_names: true)
        user_data_keys = [:id, :type, :attributes]
        attribute_keys = [:email, :api_key]

        expect(user_data[:data].keys).to eq(user_data_keys)
        expect(user_data[:data][:attributes].keys).to eq(attribute_keys)
        expect(user_data[:data][:attributes][:email]).to eq("whatever@example.com")
        expect(user_data[:data][:attributes][:api_key]).to be_a(String)
        expect(user_data[:data][:attributes][:api_key].length).to eq(30)

        expect(User.count).to eq(1)
      end
    end

    describe "failure" do
      it "returns 409 when an email already exists", :vcr do
        User.create!({
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        })

        post "http://localhost:3000/api/v0/users", headers: @headers, params: JSON.generate({
          "email": "whatever@example.com",
          "password": "password",
          "password_confirmation": "password"
        })

        expect(response).to_not be_successful
        expect(response.status).to eq(409)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:errors].first[:status]).to eq(409)
        expect(data[:errors].first[:detail]).to eq("PG::UniqueViolation: ERROR:  duplicate key value violates unique constraint \"index_users_on_email\"\nDETAIL:  Key (email)=(whatever@example.com) already exists.\n")
      end
    end
  end
end
