class CreateApplicantForm
  include ActiveModel::Validations

  validate :check_empty_job_param
  validate :check_existing_profile
  validate :check_profile_email
  validate :check_published_job
  validate :check_empty_job_id

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
    return false unless valid?

    create_applicant(@applicant_param)
  end

  private

  def create_applicant(applicant_param = {})
    if applicant_param[:profile_id].present? && Profile.find(applicant_param[:profile_id]).present?
      Applicant.create!(applicant_param)
    elsif @profile_param[:email].present?
      profile = find_or_create_profile(@profile_param)
      Applicant.create!(applicant_param.merge(profile_id: profile.id))
    end
  end

  def check_existing_profile
    return if @applicant_param[:profile_id].blank?

    return if (Profile.find_by(id: @applicant_param[:profile_id]) || {}).present?

    errors.add(:error, 'Profile not found.')
  end

  def find_or_create_profile(profile_param = {})
    Profile.find_by(email: profile_param[:email]) || Profile.create!(profile_param)
  end

  def check_empty_job_param
    return if @applicant_param[:profile_id].present? || @profile_param[:email].present?

    errors.add(:error, 'Profile is required.')
  end

  def check_profile_email
    return if @applicant_param[:profile_id].present?

    return if @profile_param[:email].present?

    errors.add(:error, 'Profile email is required.')
  end

  def check_published_job
    return if @applicant_param[:job_id].blank?

    return unless Job.find(@applicant_param[:job_id]).status == 'draft'

    errors.add(:error, 'Job is not published.')
  end

  def check_empty_job_id
    return if @applicant_param[:job_id].present?

    errors.add(:error, 'Job id is required.')
  end
end
