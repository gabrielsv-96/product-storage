class StockItemsController < ApplicationController
  before_action :set_stock_item, only: %i[ show update destroy ]

  def index
    @stock_items = StockItem.all
  end

  def show; end

  def create
    @stock_item = StockItem.new(stock_item_params)

    if @stock_item.save
      render :show, status: :created, location: @stock_item
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @stock_item.update(stock_item_params)
      render :show, status: :ok, location: @stock_item
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @stock_item.destroy
  end

  private

    def set_stock_item
      @stock_item = StockItem.find(params[:id])
    end

    def stock_item_params
      params.require(:stock_item).permit(:quantity, :product_id, :store_id)
    end
end
