module Types
  module Data
    class ProfileData < BaseInputObject
      argument :id, ID, required: false
      argument :email, String, required: true
      argument :name, String, required: true
    end
  end
end
