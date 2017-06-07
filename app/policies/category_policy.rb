class CategoryPolicy < ApplicationPolicy

  def create?
    user.admin? || user.owner? || user.moderator?
  end

  def update?
    user.admin? || user.owner? || user.moderator?
  end

  def destroy?
    user.owner? || user.moderator?
  end
end
