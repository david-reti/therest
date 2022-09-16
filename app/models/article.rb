class Article < ApplicationRecord
  has_one :food_review
  belongs_to :user
  has_rich_text :body
  has_one_attached :cover_image

  accepts_nested_attributes_for :food_review

  default_scope -> { order 'updated_at DESC' }

  def is_food_review?
    food_review.present?
  end
end
