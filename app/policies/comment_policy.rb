class CommentPolicy < ApplicationPolicy

  def create?
    user.user? || user.admin? || user.owner? || user.moderator?
  end

  def update?
    user.user? || user.owner? || user.moderator?
  end

  def destroy?
    user.user? || user.owner? || user.moderator?
  end
end
