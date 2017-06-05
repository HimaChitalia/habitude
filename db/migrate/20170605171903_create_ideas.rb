class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.string :content

      t.references :habit, index: true, foreign_key:true
      t.references :user, index: true, foreign_key:true
      t.timestamps
    end
  end
end
