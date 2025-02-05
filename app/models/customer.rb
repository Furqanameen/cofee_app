class Customer < ApplicationRecord

  has_many :orders
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, uniqueness: true, length: { minimum: 10, maximum: 15 }
end