class CreateMilestonesStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :milestones_statuses do |t|
      t.integer :milestone_id
      t.integer :status_id
      
      t.timestamps
    end
  end
end
