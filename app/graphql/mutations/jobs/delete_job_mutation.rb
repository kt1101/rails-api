module Mutations
  module Jobs
    class DeleteJobMutation < BaseMutation
      null true

      argument :id, ID, required: true

      field :job, Types::Fields::JobType, null: true

      def resolve(id:)
        job = Job.find(id)
        ::JobPolicy.new(context[:current_user, job]).destroy?
        job.destroy
        { job: }
      end
    end
  end
end
