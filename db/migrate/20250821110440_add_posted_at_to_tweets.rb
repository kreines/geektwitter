class AddPostedAtToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :posted_at, :datetime
  end
end
