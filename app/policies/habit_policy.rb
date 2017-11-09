class HabitPolicy < ApplicationPolicy

  def update?
    user.owner?
  end

  def destroy?
    user.owner? || user.moderator?
  end
end
