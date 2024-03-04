class UserPolicy < ApplicationPolicy
  # @user is the current_user
  # @record is the user we are authorizing against
  def show?
    @user == @record
  end

  def update?
    @user == @record
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
