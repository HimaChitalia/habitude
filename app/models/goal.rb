class Goal < ApplicationRecord

belongs_to :habit
delegate :user, :to => :habit, :allow_nil => true

has_many :statuses

accepts_nested_attributes_for :statuses, reject_if: lambda {|attributes| attributes['description'].blank?}

def add_status(status)
  self.statuses = [] if self.statuses == nil
  update_attributes milestones: self.statuses.push(status)
end

end
