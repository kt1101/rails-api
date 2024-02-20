class JobsController < ApplicationController
  before_action :authenticate_user!

  def index
    jobs = current_user.jobs
    render json: jobs, status: :ok
  end

  def create
    job = current_user.jobs.build(job_params)
    if job.save
      render json: job, status: :created
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    job = current_user.jobs.find(params[:id])
    if job.update(job_params)
      render json: job, status: :ok
    else
      render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    job = current_user.jobs.find(params[:id])
    job.destroy
    render json: { message: "Job deleted successfully." }, status: :ok
  end

  private

  def job_params
    params.require(:job).permit(:title, :salary_from, :salary_to)
  end
end
