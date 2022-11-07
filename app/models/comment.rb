class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  validates :user_id, :article_id, :message, presence: true
  validates :message, length: { in: 1..2000 }

  default_scope -> { order 'updated_at DESC' }
end
