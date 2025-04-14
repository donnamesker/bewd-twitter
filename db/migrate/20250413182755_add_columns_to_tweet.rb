class AddColumnsToTweet < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets
    add_column :tweets, :message, :string
    add_column :tweets, :user_id, :integer
    add_column :tweets, :timestamps, :datetime
    add_index :tweets, :user_id
  end
end