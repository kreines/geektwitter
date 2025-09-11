class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :content, presence: true   # ← 空を禁止
end
