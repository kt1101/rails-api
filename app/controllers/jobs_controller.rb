class JobsController < ApplicationController
  before_action :set_job, only: %i[ show update destroy ]
  skip_before_action :authorized, only: %i[ show ]
  # GET /jobs
  def index
    @jobs = current_user.jobs
    render json: @jobs, status: :ok
  end

  # GET /jobs/1
  def show
    authorize @job
    render json: @job
  end

  # POST /jobs
  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      render json: @job, status: :created
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    authorize @job
    @job = current_user.jobs.find(params[:id])
    if @job.draft? && update_params[:status] == "published"
      @job.set_published_date
      @job.set_share_link
    elsif @job.published? && update_params[:status] == "draft"
      @job.published_date = nil
      @job.share_link = nil
    end
    if @job.update(update_params)
      render json: @job, status: :ok
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    authorize @job
    @job = current_user.jobs.find(params[:id])
    @job.destroy
    render json: { message: "Job deleted successfully." }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :salary_from, :salary_to)
    end

    def update_params
      params.require(:job).permit(:title, :salary_from, :salary_to, :status)
    end
end
