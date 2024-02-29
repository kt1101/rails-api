class CreateApplicantForm
  include ActiveModel::Model

  attr_reader :applicant

  def initialize(params:)
    @param = params
    @applicant_param = {
      profile_id: (@param[:applicant] || {})[:profile_id],
      job_id: (@param[:applicant] || {})[:job_id]
    }
    @profile_param = {
      email: (@param[:profile] || {})[:email],
      name: (@param[:profile] || {})[:name]
    }
  end

  def save
    return false unless Job.find(@applicant_param[:job_id]).status == "published"
    create_applicant(@applicant_param)
  end

  private
    def create_applicant(applicant_param = {})
      if applicant_param[:profile_id].present? && Profile.find(applicant_param[:profile_id]).present?
        applicant = Applicant.create!(applicant_param)
      elsif @profile_param[:email].present?
        profile = find_or_create_profile(@profile_param)
        applicant = Applicant.create!(applicant_param.merge(profile_id: profile.id))
      end
    end

    def find_or_create_profile(profile_param = {})
      profile = Profile.find_by(email: profile_param[:email]) || Profile.create!(profile_param)
    end
end