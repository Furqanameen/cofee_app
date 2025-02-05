class Shop < ApplicationRecord

  has_many :orders

  validates :name, presence: true, uniqueness: true
  validates :region, presence: true
  validates :tax_rate, presence: true, numericality: { greater_than_or_equal_to: 0 }
end