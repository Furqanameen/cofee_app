module Api::V1
  class DiscountsController < ApplicationController

    def index
      @discounts = Discount.all
      render json: @discounts, status: :ok
    end

    def show
      discount = Discount.find_by(id: params[:id])
      
      if discount
        render json: discount, status: :ok
      else
        render json: { error: "Discount not found" }, status: :not_found
      end
    end

    def create
      discount = Discount.new(discount_params)

      if discount.save
        render json: { message: "Discount created successfully", discount: discount }, status: :created
      else
        render json: { error: discount.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def discount_params
      params.permit(:name, :discount_type, :value, :condition)
    end
  end
end
