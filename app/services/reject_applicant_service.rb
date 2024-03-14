class RejectApplicantService < ApplicationService
  def call
    update_status
  end

  private

  def update_status
    return if @record[:applicant].rejected?

    @record[:applicant].update!(status: 'rejected')
    ApplicantRejectedMailer.applicant_rejected_mailer(@record[:applicant]).deliver_later
  end
end
