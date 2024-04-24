class User < ApplicationRecord
  has_secure_password

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.base58(30)
    self.api_key_hash = hash_key(api_key)
  end

  def hash_key(key)
    Digest::SHA256.hexdigest(key)
  end
end
