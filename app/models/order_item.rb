class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :discount, optional: true

  before_create :apply_discount

  private

  def apply_discount
    return if discount_applied?
    discount_data = OrderItemDiscountService.new(self).apply_discount
    self.unit_price = discount_data[:unit_price]
    self.total_price = discount_data[:total_price]
  end

  def discount_applied?
    # Assuming the flag is `true` once a discount is applied, or unit_price is zero
    unit_price == 0 && total_price == 0
  end

end
