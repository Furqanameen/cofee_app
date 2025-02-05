module Api::V1
  class ShopsController < ApplicationController

    def index
      @shops = Shop.all
      render json: @shops, status: :ok
    end

    def show
      shop = Shop.find_by(id: params[:id])
      
      if shop
        render json: shop, status: :ok
      else
        render json: { error: "Shop not found" }, status: :not_found
      end
    end

    def create
      shop = Shop.new(shop_params)

      if shop.save
        render json: { message: "Shop created successfully", shop: shop }, status: :created
      else
        render json: { error: shop.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def shop_params
      params.permit(:name, :region, :tax_rate)
    end
  end
end
