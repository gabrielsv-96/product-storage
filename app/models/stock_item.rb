class StockItem < ApplicationRecord
  belongs_to :product
  belongs_to :store 

  validates :quantity, presence: true
  validates :product_id, presence: true
  validates :store_id, presence: true
end
