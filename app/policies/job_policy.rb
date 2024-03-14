class JobPolicy < ApplicationPolicy
  # @user is the current_user
  # @record is the job we are authorizing against
  def index?
    @user.jobs.pluck(:id).uniq == @record.pluck(:id).uniq
  end

  def update?
    return false if owner?

    raise Pundit::NotAuthorizedError, 'You are not authorized to perform this action.'
  end

  def destroy?
    return false if owner?

    raise Pundit::NotAuthorizedError
  end

  def owner?
    @user.id == @record.user_id
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
