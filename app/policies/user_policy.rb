class UserPolicy < ApplicationPolicy

  def index?
    user.owner? || user.moderator?
  end

  def show?
    user.admin? || record == user || user.owner? || user.moderator?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin? || user.owner? || user.moderator?
  end
end
