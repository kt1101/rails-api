module Types
  module Data
    class UserData < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: false
      argument :password_confirmation, String, required: false
      argument :username, String, required: true
      # argument :url, String, required: false

      # def url
      #   (Rails.env.development? || Rails.env.test?) ?
      # Rails.application.routes.url_helpers.rails_blob_path(object.avatar) :
      # object.avatar.service_url
      # end
    end
  end
end
