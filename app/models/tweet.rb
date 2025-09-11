class Tweet < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    
def start_time
  created_at
end
    
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_many :comments, dependent: :destroy
end
