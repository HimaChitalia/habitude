class CreateCategoriesHabits < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_habits do |t|
      t.integer :habit_id
      t.integer :category_id

      t.timestamps
    end
  end
end
