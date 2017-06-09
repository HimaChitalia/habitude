class GoalsMilestones < ActiveRecord::Migration[5.0]
  def change
    create_table :goals_milestones do |t|
      t.integer :goal_id
      t.integer :milestone_id

      t.timestamps
    end
  end
end
