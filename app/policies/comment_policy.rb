class CommentPolicy < ApplicationPolicy

  def create?
    user.user? || user.admin? || user.owner? || user.moderator?
  end

  def update?
    user.owner? || user.moderator?
  end

  def destroy?
    user.owner? || user.moderator?
  end
end
