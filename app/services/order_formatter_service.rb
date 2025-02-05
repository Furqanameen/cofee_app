class OrderFormatterService
  def self.format(order)
    {
      id: order.id,
      customer_id: order.customer_id,
      shop_id: order.shop_id,
      order_items: order.order_items.map { |item| format_order_item(item) },
      subtotal: order.subtotal.to_f,
      tax_total: order.tax_total.to_f,
      total: order.total.to_f,
      created_at: order.created_at,
      updated_at: order.updated_at
    }
  end

  def self.format_order_item(order_item)
    total_price = order_item.total_price.to_f
    base_price = order_item.unit_price * order_item.quantity
    discount_applied = base_price - total_price

    {
      id: order_item.id,
      item_name: order_item.item.name,
      quantity: order_item.quantity,
      unit_price: order_item.unit_price.to_f,
      tax_rate: order_item.tax_rate.to_f,
      discount_applied: order_item.unit_price.zero? ? "Free Item" : discount_applied.to_f,
      final_price: total_price,
      is_free: order_item.unit_price.zero?
    }
  end
end
