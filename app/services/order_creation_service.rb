class OrderCreationService
  def initialize(customer_id, shop_id, items)
    @customer_id = customer_id
    @shop_id = shop_id
    @items = items
  end

  def call
    ActiveRecord::Base.transaction do
      shop = Shop.find(@shop_id)

      order = Order.create!(customer_id: @customer_id, shop_id: shop.id)

      @items.each do |item|
        item_record = Item.find(item[:item_id])
        order.order_items.create!(
          item_id: item_record.id,
          quantity: item[:quantity],
          unit_price: item_record.price
        )
      end

      # order.calculate_totals
      order.save!

      order
    end
  rescue ActiveRecord::RecordInvalid => e
    { error: e.message }
  rescue ActiveRecord::RecordNotFound
    { error: "Shop or Item not found" }
  rescue StandardError => e
    { error: "Something went wrong: #{e.message}" }
  end
end
