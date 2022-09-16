class AddFoodReviewToArticle < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :food_review
  end
end
