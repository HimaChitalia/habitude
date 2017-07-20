class HabitSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  belongs_to :user, serializer: UserHabitSerializer
  has_many :goals
  has_many :categories
end
