module Mutations
  module Jobs
    class UpdateJobMutation < BaseMutation
      null true

      argument :job_data, Types::Data::JobData, required: true
      argument :job_id, ID, required: true

      field :job, Types::Fields::JobType, null: true

      def resolve(job_id:, job_data:)
        job = Job.find(job_id)
        ::JobPolicy.new(context[:current_user], job).update?
        update_job = UpdateJobForm.new(job:, params: job_data.arguments.keyword_arguments)
        unless update_job.update
          raise GraphQL::ExecutionError,
                update_job.errors.full_messages.join(', ')
        end
        { job: }
      end
    end
  end
end
