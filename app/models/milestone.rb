class Milestone < ApplicationRecord

  has_many :goals_milestones
  has_and_belongs_to_many :goals

  has_many :milestones_statuses
  has_and_belongs_to_many :statuses

  accepts_nested_attributes_for :statuses, reject_if: lambda {|attributes| attributes['description'].blank?}

  def add_status(status)
    # locations_will_change!
    self.statuses = [] if self.statuses == nil
    update_attributes milestones: self.statuses.push(status)
  end

end
