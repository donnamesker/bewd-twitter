class AddForeignKeyToTweets < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :tweets, :users
  end
end
