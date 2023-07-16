class ChangeNameToEmail < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :name, :email
    add_index :users, :email, unique: true
  end
end
