module Mutations
  module Locations
    class CreateLocationMutation < BaseMutation
      null true

      argument :location_data, Types::Data::LocationData, required: true

      field :location, Types::Fields::LocationType, null: true

      def resolve(location_data:)
        location = Location.new(location_data.arguments.keyword_arguments)
        raise GraphQL::ExecutionError, job.errors.full_messages.join(', ') unless location.save

        { location: }
      end
    end
  end
end
