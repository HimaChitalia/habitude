class MilestonesStatus < ApplicationRecord

  belongs_to :milestone
  belongs_to :status
  
end
