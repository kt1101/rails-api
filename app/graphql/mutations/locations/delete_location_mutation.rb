module Mutations
  module Locations
    class DeleteLocationMutation < BaseMutation
      null true

      argument :id, ID, required: true

      field :message, String, null: true

      def resolve(id:)
        location = Location.find(id)

        unless location.destroy
          raise GraphQL::ExecutionError,
                location.errors.full_messages.join(', ')
        end

        { message: 'Location deleted' }
      end
    end
  end
end
