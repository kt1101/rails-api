# frozen_string_literal: true

class UpdateJobForm
  include ActiveModel::Model

  attr_reader :job

  def initialize(job:, params:)
    @job = job
    @param = params
    @job_param = {
      title: @param[:title],
      salary_from: @param[:salary_from],
      salary_to: @param[:salary_to],
      status: @param[:status]
    }
    @location_param = { address: (@param[:location] || {})[:address] }
  end

  def update
    return false unless valid?

    update_job(@job_param)
    update_location(@location_param)
  end

  private

  def update_job(job_params = {})
    job.update!(job_params)
  end

  def update_location(location_params = {})
    if job.location.present? && !Location.pluck(:address).include?(location_params[:address])
      job.location.update!(location_params)
    else
      job.location = Location.find_or_create_by!(location_params)
    end
  end
end
