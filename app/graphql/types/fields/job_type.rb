module Types
  module Fields
    class JobType < Types::BaseObject
      field :id, ID, null: false
      field :title, String
      field :share_link, String
      field :salary_from, Float
      field :salary_to, Float
      field :status, String
      field :published_date, GraphQL::Types::ISO8601DateTime
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :user_id, Integer
      field :location, Types::Fields::LocationType, null: true
    end
  end
end
