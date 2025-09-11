class AddMediaTagToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :media_tag, :string
  end
end
