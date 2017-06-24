class Habit < ApplicationRecord

  belongs_to :user

  has_many :categories_habits
  has_many :categories, through: :categories_habits

  validates_presence_of :category_ids

  has_many :goals
  has_many :statuses, through: :goals

  has_many :comments

  accepts_nested_attributes_for :categories, reject_if: lambda {|attributes| attributes['description'].blank?}
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
