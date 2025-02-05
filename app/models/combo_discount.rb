class ComboDiscount < ApplicationRecord
  belongs_to :discount
  belongs_to :item  # Ensure this is present

  validates :discount_id, :item_id, presence: true
  validates :free_items_count, presence: true, numericality: { only_integer: true, greater_than: 0 }
end