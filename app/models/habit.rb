class Habit < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_many :goals_habits
  has_and_belongs_to_many :goals

  has_many :ideas, through: :user

  accepts_nested_attributes_for :category, reject_if: lambda {|attributes| attributes['description'].blank?}
  accepts_nested_attributes_for :goals,
    :reject_if  => lambda {|attributes| attributes['name'].blank?},
    :allow_destroy => true

    def add_goal(goal)
      # locations_will_change!
      self.goals = [] if self.goals == nil
      update_attributes goals: self.goals.push(goal)
    end

end
