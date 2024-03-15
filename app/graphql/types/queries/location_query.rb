module Types
  module Queries
    module LocationQuery
      extend ActiveSupport::Concern

      included do
        field :locations, [Types::Fields::LocationType], null: false
        def locations
          Location.all
        end
      end
    end
  end
end
