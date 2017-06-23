class Status < ApplicationRecord

  belongs_to :goal
  delegate :habit, :to => :goal, :allow_nil => true

end
