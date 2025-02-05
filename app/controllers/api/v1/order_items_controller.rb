module Api::V1
  class OrderItemsController < ApplicationController
    # GET /api/v1/order_items
    def index
      # Eager load the associations to reduce N+1 query problems
      @order_items = OrderItem.includes(:order, :item)

      # Render the order items in JSON format
      # render json: @order_items.select(:id, :unit_price, :total_price).includes(:order, :item)
      render json: @order_items, include: [:order, :item]
    end
  end
end
