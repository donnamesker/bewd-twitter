class AddColumnsToUser < ActiveRecord::Migration[7.2]
  def change
    create_table :users
    add_column :users, :username, :string
    add_column :users, :email, :string
    add_column :users, :password, :string
    add_column :users, :timestamps, :datetime
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
