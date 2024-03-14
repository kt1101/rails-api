module Types
  class MutationType < Types::BaseObject
    field :login_mutation, mutation: Mutations::Auths::LoginMutation
    field :signup_mutation, mutation: Mutations::Auths::SignupMutation
    field :logout_mutation, mutation: Mutations::Auths::LogoutMutation

    field :update_user_mutation, mutation: Mutations::Users::UpdateUserMutation

    field :create_job_mutation, mutation: Mutations::Jobs::CreateJobMutation
    field :update_job_mutation, mutation: Mutations::Jobs::UpdateJobMutation
    field :delete_job_mutation, mutation: Mutations::Jobs::DeleteJobMutation

    field :create_applicant_mutation, mutation: Mutations::Applicants::CreateApplicantMutation
    field :update_applicant_mutation, mutation: Mutations::Applicants::UpdateApplicantMutation

    field :create_location_mutation, mutation: Mutations::Locations::CreateLocationMutation
    field :update_location_mutation, mutation: Mutations::Locations::UpdateLocationMutation
    field :delete_location_mutation, mutation: Mutations::Locations::DeleteLocationMutation

    field :search_profile_mutation, mutation: Mutations::Profiles::SearchProfileMutation
    field :update_profile_mutation, mutation: Mutations::Profiles::UpdateProfileMutation
  end
end
