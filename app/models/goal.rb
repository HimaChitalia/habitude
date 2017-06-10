class Goal < ApplicationRecord

has_many :goals_habits
has_and_belongs_to_many :habits

has_many :goals_milestones
has_and_belongs_to_many :milestones

accepts_nested_attributes_for :milestones, reject_if: lambda {|attributes| attributes['description'].blank?}

def add_milestone(milestone)
  # locations_will_change!
  self.milestones = [] if self.milestones == nil
  update_attributes milestones: self.milestones.push(milestone)
end

end
