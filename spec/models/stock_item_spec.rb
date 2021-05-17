require 'rails_helper'

RSpec.describe StockItem, :type => :model do
  before do
    @product = Product.create!(name: Faker::App.name, price: rand(1.00...2000.00))
    @store = Store.create!(name: Faker::App.name, address: Faker::Address.street_address)
  end

  it 'should not be a valid stock without a quantity' do
    stock = StockItem.new(quantity: nil)
    expect(stock).to_not be_valid
  end

  it 'should not be not a valid stock without a store' do
    stock = StockItem.new(quantity: 10, product_id: @product.id, store_id: nil)
    expect(stock).to_not be_valid
  end

  it 'should not be not a valid stock without a product' do
    stock = StockItem.new(quantity: 10, product_id: nil, store_id: @store.id)
    expect(stock).to_not be_valid
  end

  it 'should be a valid stock with valid values' do
    stock = StockItem.new(quantity: 10, product_id: @product.id, store_id: @store.id)
    expect(stock).to be_valid
  end
end
