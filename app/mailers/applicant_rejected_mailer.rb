class ApplicantRejectedMailer < ApplicationMailer
  def applicant_rejected_mailer(applicant)
    @applicant = applicant
    @profile = Profile.find(@applicant.profile_id)
    subject = "Your application for the #{Job.find(@applicant.job_id).title} has been rejected."
    mail to: @profile.email, subject:
  end
end
