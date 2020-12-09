class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :slack_id
end
