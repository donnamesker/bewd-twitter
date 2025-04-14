class AddColumnsToSession < ActiveRecord::Migration[7.2]
  def change
    create_table :sessions
    add_column :sessions, :token, :string
    add_column :sessions, :user_id, :integer
    add_column :sessions, :timestamps, :datetime
    add_index :sessions, :user_id
  end
end
