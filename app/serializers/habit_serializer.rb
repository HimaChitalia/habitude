class HabitSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  belongs_to :user
  has_many :goals
  has_many :categories
  has_many :comments
end
