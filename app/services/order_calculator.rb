class OrderCalculator
  def initialize(order)
    @order = order
  end

  def calculate
    return if @order.shop.nil?

    {
      subtotal: calculate_subtotal,
      tax_total: calculate_tax,
      total: calculate_total
    }
  end

  private

  def calculate_subtotal
    @order.order_items.sum("quantity * unit_price")
  end

  def calculate_tax
    subtotal = calculate_subtotal
    tax_rate = @order.shop.tax_rate.to_f

    return 0 if tax_rate <= 0 # Apply tax only when tax_rate > 0

    (subtotal * tax_rate / 100).round(2)
  end

  def calculate_total
    subtotal = calculate_subtotal
    tax = calculate_tax
    (subtotal + tax - @order.discount_total.to_f).round(2)
  end
end
