module Types
  module Data
    class JobData < BaseInputObject
      argument :id, ID, required: false
      argument :title, String, required: true
      argument :salary_from, Float, required: true
      argument :salary_to, Float, required: true
      argument :status, String, required: false
      argument :location, Types::Data::LocationData, required: true
    end
  end
end
