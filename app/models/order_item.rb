class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :discount, optional: true

  before_validation :apply_discount, on: [:create, :update]

  private

  def apply_discount
    discount_data = OrderItemDiscountService.new(self).apply_discount
    self.unit_price = discount_data[:unit_price]
    self.total_price = discount_data[:total_price]
  end
end
