class PublishedJobMailer < ApplicationMailer
  def published_job_mailer(job)
    @job = job
    @user = User.find(job.user_id)
    subject = "#{@job.title} has been published"
    mail to: @user.email, subject:
  end
end
