class Habit < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_many :goals_habits
  has_and_belongs_to_many :goals
  
  has_many :ideas, through: :user

  accepts_nested_attributes_for :category, reject_if: lambda {|attributes| attributes['description'].blank?}

end
