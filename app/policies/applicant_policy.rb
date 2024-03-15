class ApplicantPolicy < ApplicationPolicy
  # @user is the user
  # @record is the applicant we are authorizing against
  def index?
    @user.id == Job.where(id: @record.pluck(:job_id).uniq).pluck(:user_id).uniq[0]
  end

  def update?
    return true if @user == @record.job.user

    raise Pundit::NotAuthorizedError
  end
end
