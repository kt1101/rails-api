class UserSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer

  attributes :id, :email, :username

  attribute :avatar do |user|
    "http://127.0.0.1:3000" + Rails.application.routes.url_helpers.rails_blob_path(user.avatar, only_path: true) if user.avatar.attached?
  end
end
