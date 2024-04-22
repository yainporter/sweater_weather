require "rails_helper"

RSpec.describe ErrorMessage do
  describe "initialization" do
    it "creates an error message" do
      expect(ErrorMessage.new("Error", 404)).to be_an ErrorMessage
    end
    it "has two attributes" do
      error_message = ErrorMessage.new("Error", 404)

      expect(error_message.message).to eq("Error")
      expect(error_message.status_code).to eq(404)
    end
  end
end
