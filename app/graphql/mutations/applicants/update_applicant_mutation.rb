module Mutations
  module Applicants
    class UpdateApplicantMutation < BaseMutation
      null true

      argument :applicant_id, ID, required: true

      field :applicant, Types::Fields::ApplicantType, null: true
      field :message, String, null: false

      def resolve(applicant_id:)
        applicant = Applicant.find(applicant_id)
        authorize(obj: applicant, ctx: context)
        reject_applicant_service = RejectApplicantService.new(applicant:)
        unless reject_applicant_service.call
          raise GraphQL::ExecutionError,
                'Reject applicant unsuccesful'
        end
        {
          message: 'Applicant rejected successfully',
          applicant:
        }
      end
    end
  end
end
