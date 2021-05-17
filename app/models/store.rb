class Store < ApplicationRecord
  has_many :stock_items

  validates :name, presence: true
  validates :address, presence: true
end
