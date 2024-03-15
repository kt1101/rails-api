module Types
  module Queries
    module UserQuery
      extend ActiveSupport::Concern

      included do
        field :user, Types::Fields::UserType, null: false
        def user
          context[:current_user] || []
        end
      end
    end
  end
end
