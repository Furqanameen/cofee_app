class NotifyCustomerJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find_by(id: order_id)
    return unless order

    customer = order.customer
    puts "Notification sent to #{customer.email}: Your order ##{order.id} is now completed!"
  end
end
