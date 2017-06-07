class CreateMilestones < ActiveRecord::Migration[5.0]
  def change
    create_table :milestones do |t|
      t.string :description

      t.references :goal, index: true, foreign_key:true
      t.timestamps
    end
  end
end
