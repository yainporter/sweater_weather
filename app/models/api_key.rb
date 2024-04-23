class ApiKey < ApplicationRecord
  HMAC_SECRET_KEY = Rails.application.credentials.api_key_hmac_secret_key

  belongs_to :bearer, polymorphic: true

  before_create :generate_token
  attr_reader :token

  private

  def generate_token
    self.raw_token = SecureRandom.base58(30)
  end
end
