class FoodReview < ApplicationRecord
  has_one :cuisine
  belongs_to :article
  belongs_to :city
  belongs_to :cuisine
  accepts_nested_attributes_for :city, :cuisine

  enum rating: [ :very_poor, :underwhelming, :good, :very_good ]
  enum price: [ :cheap, :reasonable, :expensive ]
end
