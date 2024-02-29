class ApplicantRejectedMailer < ApplicationMailer
  def applicant_rejected_mailer(applicant)
    @applicant = applicant
    @profile = Profile.find(@applicant.profile_id)
    mail to: @profile.email, subject: "Your application has been rejected."
  end
end