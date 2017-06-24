class Category < ApplicationRecord

  has_many :categories_habits
  has_many :habits, through: :categories_habits

end
