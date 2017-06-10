class Milestone < ApplicationRecord

  has_many :goals_milestones
  has_and_belongs_to_many :goals

  has_many :milestones_statuses
  has_and_belongs_to_many :statuses

end
