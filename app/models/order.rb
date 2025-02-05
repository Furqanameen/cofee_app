class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :shop
  has_many :order_items, dependent: :destroy

  before_validation :calculate_totals

  enum status: { pending: 0, paid: 1, completed: 2 }

  private

  def calculate_totals
    return unless shop.present?

    totals = OrderCalculator.new(self).calculate
    self.subtotal = totals[:subtotal]
    self.tax_total = totals[:tax_total]
    self.total = totals[:total]
  end
end
