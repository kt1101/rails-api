class ApplicantsController < ApplicationController
  before_action :set_applicant, only: %i[ show update destroy ]
  skip_before_action :authenticated, only: [:create]

  # GET /applicants
  def index
    @applicants = Applicant.where(job_id: current_user.jobs.pluck(:id))
    authorize(@applicants)
    render json: @applicants, status: :ok
  end

  # POST /applicants
  def create
    create_applicant_form = CreateApplicantForm.new(params:)
    if create_applicant_form.save
      render json: { message: "Applicant created successfully" }, status: :created
    else
      render json: create_applicant_form.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applicants/1
  def update
    authorize(@applicant)
    reject_applicant_service = RejectApplicantService.new(applicant: @applicant)
    if reject_applicant_service.call
      render json: { message: "Applicant rejected successfully" }, status: :ok
    else
      render json: reject_applicant_service.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def applicant_params
      params.require(:applicant).permit(:profile_id, :job_id)
    end
end
