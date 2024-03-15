module Mutations
  module Auths
    class SignupMutation < Mutations::BaseMutation
      null true

      argument :signup_data, Types::Data::SignupData, required: true

      field :user, Types::Fields::UserType, null: true

      def resolve(signup_data:)
        user = User.new(signup_data.arguments.keyword_arguments)
        raise GraphQL::ExecutionError, user.errors.full_messages.join(', ') unless user.save

        { user: }
      end
    end
  end
end
