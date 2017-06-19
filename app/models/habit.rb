class Habit < ApplicationRecord

  belongs_to :user
  belongs_to :category

  has_many :goals_habits
  has_and_belongs_to_many :goals

  has_many :comments

  accepts_nested_attributes_for :category, reject_if: lambda {|attributes| attributes['description'].blank?}
  accepts_nested_attributes_for :goals,
    :reject_if  => lambda {|attributes| attributes['name'].blank?},
    :allow_destroy => true

    def add_goal(goal)
      self.goals = [] if self.goals == nil
      update_attributes goals: self.goals.push(goal)
    end

    def self.search(search)
      # if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "postgresql"
      #   where("category_id::text LIKE ?", search)
      # elsif ActiveRecord::Base.connection.instance_values["config"][:adapter] == "sqlite3"
      #   where("category_id LIKE ?", search)
      # end
      scope :search, ->(search) { where(category_id: search) }
    end

end
