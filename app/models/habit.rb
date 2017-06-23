class Habit < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_many :goals
  has_many :statuses, through: :goals

  has_many :comments

  accepts_nested_attributes_for :category, reject_if: lambda {|attributes| attributes['description'].blank?}
  accepts_nested_attributes_for :goals,
    :reject_if  => lambda {|attributes| attributes['name'].blank?},
    :allow_destroy => true

    scope :search, ->(search) { where(category_id: search) if search.present?}
    scope :recent, -> { order("habits.updated_at DESC") }

    def add_goal(goal)
      self.goals = [] if self.goals == nil
      update_attributes goals: self.goals.push(goal)
    end

end
