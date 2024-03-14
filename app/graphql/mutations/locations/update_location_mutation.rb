module Mutations
  module Locations
    class UpdateLocationMutation < BaseMutation
      null true

      argument :location_data, Types::Data::LocationData, required: true

      field :location, Types::Fields::LocationType, null: true

      def resolve(location_data:)
        location_args = location_data.arguments.keyword_arguments
        location = Location.find(location_args[:id])

        unless location.update(location_args)
          raise GraphQL::ExecutionError,
                job.errors.full_messages.join(', ')
        end

        { location: }
      end
    end
  end
end
