class UserSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer
  attributes :id, :email, :username, :avatar
end
