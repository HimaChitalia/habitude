class Milestone < ApplicationRecord

  has_many :goals_milestones
  has_many :goals, through: :goals_milestones
  has_many :habits, through: :goals
  has_many :users, through: :habits

  has_many :milestones_statuses
  has_many :statuses, through: :milestones_statuses

  accepts_nested_attributes_for :statuses, reject_if: lambda {|attributes| attributes['description'].blank?}

  def add_status(status)
    # locations_will_change!
    self.statuses = [] if self.statuses == nil
    update_attributes milestones: self.statuses.push(status)
  end

end
