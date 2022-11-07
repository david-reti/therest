class Session < ApplicationRecord
    include ActiveModel::Base

    validates :email, :password, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: 8 }
end
