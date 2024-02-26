class FeedbackMailer < ApplicationMailer
  default from: "from@example.com"
  layout 'mailer'

  def feedback_mailer job
    @job = job
    @user = User.find(job.user_id)
    mail to: @user.email, subject: "Your job status has been published."
  end
end