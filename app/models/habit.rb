class Habit < ApplicationRecord

  belongs_to :user
  has_one :goal
  has_many :milestones, through: :goal
  has_many :ideas, through: :goal
  
end
