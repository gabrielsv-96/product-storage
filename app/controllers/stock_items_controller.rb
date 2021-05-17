class StockItemsController < ApplicationController
  before_action :set_stock_item, only: %i[ show update destroy ]
  before_action :validates_parameters, only: :update

  def_param_group :stock_get do
    param :stock_items, Hash, :required => true do
      param :id, :number, desc: 'Stock id'	  
      param :quantity, Integer, :required => true, desc: 'Stock quantity of items'
      param :created_at, Date, :required => true, desc: 'Date and time of the stock creation'
      param :updated_at, Date, :required => true, desc: 'Date and time of the stock last update'
      param :product_info, Hash, :required => true do
        param :name, String, :required => true, desc: 'Product name'
        param :price, Float, :required => true, desc: 'Product price'
        param :brand, String, desc: 'Product brand'
        param :product_url, String, :required => true, desc: 'Url of the specific product'
      end
      param :store_info, Hash, :required => true do
        param :store_name, String, :required => true, desc: 'Store name'
        param :store_address, Float, :required => true, desc: 'Store address'
        param :store_url, String, :required => true, desc: 'Url of the specific store'
      end
    end
  end

  def_param_group :stock_post do
    param :quantity, Integer, :required => true, desc: 'Stock quantity of items'
    param :product_id, Integer, :required => true, desc: 'Id of the product for the stock'
    param :store_id, Integer, desc: 'Id of the store for the stock'
  end

  def_param_group :stock_quantity_change do
    param :quantity_add, Integer, desc: 'Quantity of items to add to the stock'
    param :quantity_take, Integer, desc: 'Quantity of items to take from the stock'
  end

  api :GET, '/stock_items', 'Shows all stocks'  
  returns array_of: :stock_get, code: 200, desc: 'All stocks with respective products and stores' 

  def index
    @stock_items = StockItem.all
  end

  api :GET, '/stock_items/:id', 'Shows a specific stock'  
  param :id, :number, desc: 'id of the requested stock'
  returns array_of: :stock_get, code: 200, desc: 'The specific stock with its respective product and store' 

  def show; end

  api :POST, '/stock_items', 'Create a stock'
  param_group :stock_post
  returns array_of: :stock_get, code: 201, desc: 'The specific stock with its respective product and store' 

  def create
    @stock_item = StockItem.new(stock_item_params)

    if @stock_item.save
      render :show, status: :created, location: @stock_item
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, '/stock_items/:id', 'Changes the quantity of items of a stock'
  param :id, :number, desc: 'id of the requested product'
  param_group :stock_quantity_change
  returns array_of: :stock_get, code: 200, desc: 'The updated stock with its respective product and store' 

  def update
    if @stock_item.update_quantity(stock_item_params).save
      render :show, status: :ok, location: @stock_item
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, '/stock_items/:id', 'Deletes a stock'
  param :id, :number, desc: 'id of the requested stock'
  returns code: 204, desc: 'Successfull deletion of the stock' 

  def destroy
    @stock_item.destroy
  end

  private

    def validates_parameters
      if stock_item_params[:quantity_add].present? && stock_item_params[:quantity_take].present?
        render json: { error: 'Only one value is accepted in order for adding or taking from the quantity.' }, status: 400
      elsif stock_item_params[:quantity_add].blank? && stock_item_params[:quantity_take].blank?
        render json: { error: 'A value is required in order for adding or taking from the quantity.' }, status: 400
      elsif stock_item_params[:quantity_take].present? && stock_item_params[:quantity_take].to_i > @stock_item.quantity.to_i
        render json: { 
          error: "There is not enough items in stock to take, there is #{@stock_item.quantity} items currently on stock"\
          " and you are requiring #{stock_item_params[:quantity_take]} items." 
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