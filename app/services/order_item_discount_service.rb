class OrderItemDiscountService
  def initialize(order_item)
    @order_item = order_item
    @unit_price = order_item.item.price
    @quantity = order_item.quantity
    @discount = order_item.item.discounts.first
  end

  def apply_discount
    {
      unit_price: @unit_price,
      total_price: calculate_total_price
    }
  end

  private

  def calculate_total_price
    base_price = @unit_price * @quantity
    return base_price unless @discount

    case @discount.discount_type
    when "percentage"
      apply_percentage_discount(base_price)
    when "combo"
      apply_combo_discount(base_price)
    else
      base_price
    end
  end

  def apply_percentage_discount(base_price)
    discount_amount = base_price * (@discount.value.to_f / 100)
    [base_price - discount_amount, 0].max
  end

  def apply_combo_discount(base_price)
    combo_discount = @discount.combo_discounts.find_by(item: @order_item.item)
    return base_price unless combo_discount

    # Get the condition for the discount (e.g., Buy 2, Get 1 Free)
    discount_condition = @discount.condition.to_i # Example: 2 (Buy 2)

    return base_price if discount_condition.zero? # Prevent division errors

    # Calculate how many free items should be given
    free_items = (@quantity / discount_condition) * combo_discount.free_items_count

    create_free_order_items(free_items)

    base_price
  end

  def create_free_order_items(free_items)
    return if free_items.zero?

    free_items.times do
      @order_item.order.order_items.create!(
        item: @order_item.item,
        quantity: 1,
        unit_price: 0, # Free item, price is 0
        total_price: 0
      )
    end
  end
end
