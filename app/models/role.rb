class Role < ApplicationRecord
  validates :name, presence: true
  validates :permissions, length: { minimum: 1 }
  has_and_belongs_to_many :permissions
  has_and_belongs_to_many :users
end
