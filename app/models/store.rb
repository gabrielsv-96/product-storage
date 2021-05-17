class Store < ApplicationRecord
  has_many :stock_items

  validates_presence_of :name, message: 'Name is required'
  validates_presence_of :address, message: 'Address is required'
end
