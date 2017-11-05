class GoalSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :habit, serializer: HabitGoalSerializer
end