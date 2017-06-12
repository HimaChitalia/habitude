class Status < ApplicationRecord

  has_many :milestones_statuses
  has_and_belongs_to_many :milestones

end
