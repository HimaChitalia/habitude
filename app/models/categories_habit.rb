class CategoriesHabit < ApplicationRecord

  belongs_to :habit
  belongs_to :category

  scope :search, ->(search) { where(category_id: search) if search.present?}
  scope :recent, -> { order("habits.updated_at DESC") }

end
