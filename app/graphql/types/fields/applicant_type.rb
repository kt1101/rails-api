module Types
  module Fields
    class ApplicantType < Types::BaseObject
      field :id, ID, null: false
      field :job_id, ID, null: false
      field :profile_id, ID, null: false
      field :job, Types::Fields::JobType, null: false
      field :profile, Types::Fields::ProfileType, null: false
    end
  end
end
