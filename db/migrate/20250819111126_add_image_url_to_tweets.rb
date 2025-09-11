class AddImageUrlToTweets < ActiveRecord::Migration[7.2]
  def change
    add_column :tweets, :image_url, :string
  end
end
