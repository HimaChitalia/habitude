class Milestone < ApplicationRecord

  has_many :goals_milestones
  has_and_belongs_to_many :goals

end
