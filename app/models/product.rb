class Product < ApplicationRecord
  has_many :stock_items

  validates_presence_of :name, message: 'Name is required'
  validates_presence_of :price, message: 'Price is required'
end
