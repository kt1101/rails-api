module Types
  module Data
    class LocationData < BaseInputObject
      argument :id, ID, required: false
      argument :address, String, required: true
    end
  end
end
