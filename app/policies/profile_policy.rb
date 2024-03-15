class ProfilePolicy < ApplicationPolicy
  def update?
    return true if @user.admin?

    raise Pundit::NotAuthorizedError
  end
end
