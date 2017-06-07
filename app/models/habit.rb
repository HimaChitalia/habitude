class Habit < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_one :goal
  has_many :milestones, through: :goal
  has_many :ideas, through: :user

  accepts_nested_attributes_for :category, reject_if: lambda {|attributes| attributes['description'].blank?}

end
