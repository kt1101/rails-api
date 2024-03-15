module Mutations
  module Jobs
    class CreateJobMutation < BaseMutation
      null true

      argument :job_data, Types::Data::JobData, required: true

      field :job, Types::Fields::JobType, null: true

      def resolve(job_data:)
        job = context[:current_user].jobs.build(job_data.arguments.keyword_arguments)
        raise GraphQL::ExecutionError, job.errors.full_messages.join(', ') unless job.save

        { job: }
      end
    end
  end
end
