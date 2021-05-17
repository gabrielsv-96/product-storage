class StockItemsController < ApplicationController
  before_action :set_stock_item, only: %i[ show update destroy ]
  before_action :validates_parameters, only: :update

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
    if @stock_item.update_quantity(stock_item_params).save
      render :show, status: :ok, location: @stock_item
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @stock_item.destroy
  end

  private

    def validates_parameters
      if stock_item_params[:quantity_add].present? && stock_item_params[:quantity_take].present?
        render json: { error: 'Only one value is accepted in order for adding or taking from the quantity.' }, status: 400
      elsif stock_item_params[:quantity_add].blank? && stock_item_params[:quantity_take].blank?
        render json: { error: 'A value is required in order for adding or taking from the quantity.' }, status: 400
      elsif stock_item_params[:quantity_take].present? && stock_item_params[:quantity_take] > @stock_item.quantity
        render json: { 
          error: "There is not enough items in stock to take, there is #{@stock_item.quantity} items currently on stock and you are requiring #{stock_item_params[:quantity_take]} items." 
        }, status: 400
      end 
    end

    def set_stock_item
      @stock_item = StockItem.find(params[:id])
    end

    def stock_item_params
      params.permit(:quantity, :quantity_add, :quantity_take, :product_id, :store_id)
    end
end