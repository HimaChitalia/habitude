class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description, :user_id, :habit_id
  belongs_to :habit, serializer: HabitCommentSerializer
  belongs_to :user, serializer: UserCommentSerializer
end
