module Types
  module Fields
    class LocationType < Types::BaseObject
      field :id, ID, null: false
      field :address, String
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
