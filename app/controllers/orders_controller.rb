class OrdersController < ApplicationController
	def show
    	@order = Order.includes(order_items: :item).find(params[:id])
  	end
end