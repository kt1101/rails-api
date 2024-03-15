module Types
  module Data
    class UserData < BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: false
      argument :password_confirmation, String, required: false
      argument :username, String, required: true
    end
  end
end
