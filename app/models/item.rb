class Item < ApplicationRecord
  has_many :combo_discounts, dependent: :destroy
  has_many :discounts, through: :combo_discounts
  has_many :order_items, dependent: :destroy

  validates :name, :price, presence: true
end