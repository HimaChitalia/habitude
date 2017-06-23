class Goal < ApplicationRecord

has_many :goals_habits
has_many :habits, through: :goals_habits
has_many :users, through: :habits

has_many :goals_milestones
has_many :milestones, through: :goals_milestones
has_many :statuses, through: :milestones

accepts_nested_attributes_for :milestones, reject_if: lambda {|attributes| attributes['description'].blank?}

def add_milestone(milestone)
  # locations_will_change!
  self.milestones = [] if self.milestones == nil
  update_attributes milestones: self.milestones.push(milestone)
end

end
