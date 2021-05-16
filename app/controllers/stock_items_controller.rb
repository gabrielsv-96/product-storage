class StockItemsController < ApplicationController
  before_action :set_stock_item, only: %i[ show update destroy ]

  # GET /stock_items
  # GET /stock_items.json
  def index
    @stock_items = StockItem.all
  end

  # GET /stock_items/1
  # GET /stock_items/1.json
  def show
  end

  # POST /stock_items
  # POST /stock_items.json
  def create
    @stock_item = StockItem.new(stock_item_params)

    if @stock_item.save
      render :show, status: :created, location: @stock_item
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stock_items/1
  # PATCH/PUT /stock_items/1.json
  def update
    if @stock_item.update(stock_item_params)
      render :show, status: :ok, location: @stock_item
    else
      render json: @stock_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stock_items/1
  # DELETE /stock_items/1.json
  def destroy
    @stock_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_item
      @stock_item = StockItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_item_params
      params.require(:stock_item).permit(:quantity, :product_id, :store_id)
    end
end
