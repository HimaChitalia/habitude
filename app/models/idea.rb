class Comment < ApplicationRecord
  belongs_to :habit
  belongs_to :user
end
