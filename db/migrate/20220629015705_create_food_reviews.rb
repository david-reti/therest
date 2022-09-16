class CreateFoodReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :food_reviews do |t|
      t.references :article, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :cuisine, null: false, foreign_key: true
      t.integer :rating
      t.integer :price

      t.timestamps
    end
  end
end
