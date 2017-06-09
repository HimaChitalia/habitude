class GoalsHabits < ActiveRecord::Migration[5.0]
  def change
    create_table :goals_habits do |t|
      t.integer :habit_id
      t.integer :goal_id

      t.timestamps
    end
  end
end
