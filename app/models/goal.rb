class Goal < ApplicationRecord

  belongs_to :habit
  delegate :user, :to => :habit
  has_many :milestones

end
