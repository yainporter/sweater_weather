class UserSerializer
  include JSONAPI::Serializer
  attributes :email

  attribute :api_key do |object|
    api_key = ApiKey.create(bearer: object)
    api_key.raw_token
  end
end
