class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string :description


      t.references :habit, index: true, foreign_key:true
      t.timestamps
    end
  end
end
