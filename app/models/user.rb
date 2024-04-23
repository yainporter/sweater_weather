class User < ApplicationRecord
  has_secure_password
  has_many :api_keys, as: :bearer
end
