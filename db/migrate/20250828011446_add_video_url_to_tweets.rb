class AddVideoUrlToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :video_url, :string
  end
end
