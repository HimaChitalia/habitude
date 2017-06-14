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
      # locations_will_change!
      self.goals = [] if self.goals == nil
      update_attributes goals: self.goals.push(goal)
    end

    def self.search(search)
      # where("category_id LIKE ?", search.to_i)
      # category = Category.find_by(name: search)
        # where("category_id LIKE ?", category_id)
    search_result =  where("category_id::text LIKE ?", 'search')
    end

end
