class UserSerializer < ActiveModel::Serializer
  include JSONAPI::Serializer

  attributes :id, :email, :username

  attribute :avatar do |user|
    if user.avatar.attached?
      "http://127.0.0.1:3000#{
        Rails.application.routes.url_helpers.rails_blob_path(user.avatar, only_path: true)
      }"
    end
  end
end
