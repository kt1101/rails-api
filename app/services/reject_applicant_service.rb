class RejectApplicantService < ApplicationService
  def call
    update_status
  end

  private

  def update_status
    @object[:applicant].update!(status: 'rejected')
    ApplicantRejectedMailer.applicant_rejected_mailer(@object[:applicant]).deliver_later
  end
end
