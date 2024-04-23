class User < ApplicationRecord
  has_secure_password

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.base58(30)
  end
end
