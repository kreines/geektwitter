class AddCompletedToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :completed, :boolean
  end
end
