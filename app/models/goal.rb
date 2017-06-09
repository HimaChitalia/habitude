class Goal < ApplicationRecord

has_many :goals_habits
has_and_belongs_to_many :habits

has_many :goals_milestones
has_and_belongs_to_many :milestones

end
