module Api::V1
  class OrdersController < ApplicationController

    def index
      @orders = Order.includes(order_items: :item) # Eager load items
      render json: @orders.map { |order| OrderFormatterService.format(order) }, status: :ok
    end

    def create
      result = OrderCreationService.new(params[:customer_id], params[:shop_id], params[:items]).call
      if result.is_a?(Order)
        render json: { message: "Order created successfully", order: OrderFormatterService.format(result) }, status: :created
      else
        render json: { error: result[:error] }, status: :unprocessable_entity
      end
    end

    def show
      order = Order.includes(order_items: :item).find_by(id: params[:id])

      if order
        render json: OrderFormatterService.format(order), status: :ok
      else
        render json: { error: "Order not found" }, status: :not_found
      end
    end

    def update
      order = Order.find_by(id: params[:id])
      return render json: { error: "Order not found" }, status: :not_found if order.nil?

      if order.update(status: params[:status])
        NotifyCustomerJob.perform_later(order.id) if order.completed?
        render json: { message: "Order updated successfully", order: OrderFormatterService.format(order) }, status: :ok
      else
        render json: { error: order.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def order_params
      params.permit(:customer_id, :shop_id)
    end
  end
end
