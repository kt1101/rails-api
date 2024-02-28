class JobsController < ApplicationController
  before_action :set_job, only: %i[ update destroy share_link ]
  skip_before_action :authenticated, only: %i[ share_link ]

  # GET /jobs
  def index
    @jobs = current_user.jobs
    authorize(@jobs)
    render json: JobSerializer.new(@jobs).serializable_hash, status: :ok
  end

  # POST /jobs
  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      render json: JobSerializer.new(@job).serializable_hash, status: :created
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    authorize(@job)
    @update_job = UpdateJobForm.new(job: @job, params: params[:job] || {})
    if @update_job.update
      render json: JobSerializer.new(@job).serializable_hash, status: :ok
    else
      render json: { errors: @update_job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    authorize(@job)
    if @job.destroy
      render json: { message: "Job deleted successfully." }, status: :ok
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /jobs/1/share_link
  def share_link
    if @job.published?
      render json: { job: @job }, status: :ok
    else
      render json: { message: "Job not published." }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :salary_from, :salary_to, :status)
    end
end
