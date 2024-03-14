module Mutations
  module Applicants
    class CreateApplicantMutation < BaseMutation
      null true

      argument :applicant_data, Types::Data::ApplicantData, required: true
      argument :profile_data, Types::Data::ProfileData, required: false

      field :applicant, Types::Fields::ApplicantType, null: true

      def resolve(applicant_data:, profile_data:)
        params = {
          applicant: applicant_data.arguments.keyword_arguments,
          profile: profile_data.arguments.keyword_arguments
        }
        create_applicant_form = CreateApplicantForm.new(params:)
        applicant = create_applicant_form.save
        { applicant: }
      end
    end
  end
end
