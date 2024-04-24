require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_uniqueness_of(:email) }
  end

  describe "callback" do
    it "creates an api key and api_key_hash for a user" do
      user = User.create!(email: "test@test.test", password: "test", password_confirmation: "test")

      expect(user.api_key).to be_present
      expect(user.api_key).to be_a(String)
      expect(user.api_key.length).to eq(30)

      expect(user.api_key_hash).to be_present
      expect(user.api_key_hash).to be_a(String)
      expect(user.api_key_hash.length).to eq(64)
    end
  end
end
