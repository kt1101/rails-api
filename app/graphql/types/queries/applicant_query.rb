module Types
  module Queries
    module ApplicantQuery
      extend ActiveSupport::Concern

      included do
        field :applicants, [Types::Fields::ApplicantType], null: false
        def applicants
          Applicant.where(job_id: context[:current_user].jobs.pluck(:id))
        end
      end
    end
  end
end
