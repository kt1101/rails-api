module Mutations
  module Profiles
    class SearchProfileMutation < BaseMutation
      null true

      argument :query, String, required: true

      field :profile, [Types::Fields::ProfileType], null: true

      def resolve(query:)
        profile = Profile.search(query, { sort: ['updated_at:desc'] })
        { profile: }
      end
    end
  end
end
