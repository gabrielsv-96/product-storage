class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store 

  validates_presence_of :quantity, message: 'An initial quantity is required'
  validates_presence_of :product_id, message: 'A product id is required'
  validates_presence_of :store_id, message: 'A store id is required'

  def update_quantity(params)
    if params[:quantity_add].present?
      increment(:quantity, params[:quantity_add].to_i)
    else
      decrement(:quantity, params[:quantity_take].to_i)
    end
  end
end
