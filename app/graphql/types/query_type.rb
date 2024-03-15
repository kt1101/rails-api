module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [
      Types::NodeType,
      { null: true }
    ],
          null: true,
          description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # GET jobs
    field :jobs, [Types::Fields::JobType], null: false
    def jobs
      context[:current_user].jobs
    end

    # GET applicants
    field :applicants, [Types::Fields::ApplicantType], null: false
    def applicants
      Applicant.where(job_id: context[:current_user].jobs.pluck(:id))
    end

    # GET locations
    field :locations, [Types::Fields::LocationType], null: false
    def locations
      Location.all
    end

    # GET user/1
    field :user, Types::Fields::UserType, null: false
    def user
      context[:current_user] || []
    end
  end
end
