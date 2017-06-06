class Habit < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_one :goal
  has_many :milestones, through: :goal
  has_many :ideas, through: :user

end
