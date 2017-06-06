class UserPolicy < ApplicationPolicy

  def index?
    user.owner?
  end

  def show?
    user.admin? || record == user || user.owner
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin? || user.owner
  end
end
