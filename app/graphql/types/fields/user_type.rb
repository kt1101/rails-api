module Types
  module Fields
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :username, String
      field :email, String
      field :password_digest, String
      field :avatar, String
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
      field :role, Integer

      def avatar
        object.avatar.url if object.avatar.attached?
      end
    end
  end
end
