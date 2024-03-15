module Types
  module Data
    class ApplicantData < BaseInputObject
      argument :profile_id, ID, required: false
      argument :job_id, ID, required: true
    end
  end
end
