class Api::V1::ItemsController < ApplicationController
  # GET /api/v1/items
  def index
    @items = Item.all
    render json: @items
  end

  # GET /api/v1/items/:id
  def show
    @item = Item.find_by(id: params[:id])
    if @item
      render json: @item
    else
      render json: { error: 'Item not found' }, status: 404
    end
  end

  # POST /api/v1/items
  def create
    @item = Item.new(item_params)
    if @item.save
      render json: @item, status: :created
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :quantity)
  end
end
