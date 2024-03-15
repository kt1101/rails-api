module Types
  module Queries
    module JobQuery
      extend ActiveSupport::Concern

      included do
        field :jobs, [Types::Fields::JobType], null: false
        def jobs
          context[:current_user].jobs
        end
      end
    end
  end
end
