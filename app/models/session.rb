class Session < ApplicationRecord
    include ActiveModel::Model

    validates :email, :password, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: 8 }
end
