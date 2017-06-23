class Status < ApplicationRecord

  has_many :milestones_statuses
  has_many :milestones, through: :milestones_statuses
  has_many :goals, through: :milestones
  has_many :habits, through: :goals
  has_many :users, through: :habits

end
