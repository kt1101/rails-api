class JobPolicy < ApplicationPolicy
  # @user is the current_user
  # @record is the job we are authorizing against
  def index?
    @user.jobs.pluck(:id).uniq == @record.pluck(:id).uniq
  end

  def update?
    return true if owner?

    raise Pundit::NotAuthorizedError
  end

  def destroy?
    return true if owner?

    raise Pundit::NotAuthorizedError
  end

  def owner?
    @user.id == @record.user_id
  end
end
