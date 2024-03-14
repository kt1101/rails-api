module Mutations
  module Profiles
    class UpdateProfileMutation < BaseMutation
      null true

      argument :profile_data, Types::Data::ProfileData, required: true

      field :profile, Types::Fields::ProfileType, null: false

      def resolve(profile_data:)
        profile_args = profile_data.arguments.keyword_arguments
        profile = Profile.find(profile_args[:id])
        unless profile.update(profile_args)
          raise Graphql::ExecutionError, location.errros.full_messages.join(', ')
        end

        { profile: }
      end
    end
  end
end
