class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :comments, dependent: :destroy

  validates :name, presence: true #追記
  validates :profile, length: { maximum: 170 } #追記


  has_one_attached :profile_image

  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end

  before_validation :normalize_started_at

private
def normalize_started_at
  if started_at.is_a?(String) && started_at.match?(/^\d{4}$/)
    self.started_at = Date.new(started_at.to_i, 1, 1)
  end
end

end
