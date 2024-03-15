module Mutations
  module Auths
    class LogoutMutation < BaseMutation
      null true

      field :message, String, null: true

      def resolve
        unless context[:token].destroy!
          raise GraphQL::ExecutionError, context[:token].errors.full_messages.join(', ')
        end

        { message: 'Logged out successfully' }
      end
    end
  end
end
