class CreateHabits < ActiveRecord::Migration[5.0]
  def change
    create_table :habits do |t|
      t.string :name
      t.string :discription

      t.references :category, index: true, foreign_key:true
      t.references :user, index: true, foreign_key:true
      t.timestamps
    end
  end
end
