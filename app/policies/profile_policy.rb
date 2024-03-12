class ProfilePolicy < ApplicationPolicy
  def update?
    @user.admin?
  end
end
