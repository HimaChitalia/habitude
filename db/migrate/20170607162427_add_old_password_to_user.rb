class AddOldPasswordToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :old_password, :string
  end
end
