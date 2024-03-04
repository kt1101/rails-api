class JobPolicy < ApplicationPolicy
  # @user is the current_user
  # @record is the job we are authorizing against
  def index?
    @user.jobs.pluck(:id).uniq == @record.pluck(:id).uniq
  end

  def update?
    @user.id == @record.user_id
  end

  def destroy?
    @user.id == @record.user_id
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
