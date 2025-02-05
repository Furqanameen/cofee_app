module Api::V1
  class ComboDiscountsController < ApplicationController

    def index
      @combo_discounts = ComboDiscount.all
      render json: @combo_discounts, status: :ok
    end

    def show
      combo_discount = ComboDiscount.find_by(id: params[:id])

      if combo_discount
        render json: combo_discount, status: :ok
      else
        render json: { error: "Combo discount not found" }, status: :not_found
      end
    end

    def create
      combo_discount = ComboDiscount.new(combo_discount_params)

      if combo_discount.save
        render json: { message: "Combo discount created successfully", combo_discount: combo_discount }, status: :created
      else
        render json: { error: combo_discount.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def combo_discount_params
      params.permit(:discount_id, :item_id, :free_items_count)
    end
  end
end
