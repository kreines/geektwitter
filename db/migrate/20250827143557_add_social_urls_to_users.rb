class AddSocialUrlsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :x_url, :string
    add_column :users, :instagram_url, :string
    add_column :users, :facebook_url, :string
    add_column :users, :youtube_url, :string
  end
end
