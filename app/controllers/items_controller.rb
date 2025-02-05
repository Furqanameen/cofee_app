# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  # GET /items
  def index
    @items = Item.all
  end

  def buy
    @item = Item.find(params[:id])
    @shop_id = params[:shop_id]
    @customer_id = params[:customer_id]
    @discount_id = params[:discount_id]
    # Perform necessary actions, such as creating an order or processing the purchase
    # You might want to create an order or some other related logic here
    
    render json: { message: "Item bought successfully", item: @item, shop_id: @shop_id, customer_id: @customer_id, discount_id: @discount_id }
  end

  # GET /items/1
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    redirect_to items_url, notice: 'Item was successfully destroyed.'
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:name, :price, :discount, :region_id)
    end
end
