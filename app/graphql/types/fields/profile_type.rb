module Types
  module Fields
    class ProfileType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :email, String, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
