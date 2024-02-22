class JobPolicy < ApplicationPolicy
  attr_reader :user, :job

  def initialize(user, job)
    @user = user
    @job = job
  end

  def index?
    job.where(user_id: user.id).count == job.count
  end

  def update?
    user.id == job.user_id
  end

  def destroy?
    user.id == job.user_id
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
