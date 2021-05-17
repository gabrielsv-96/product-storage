require 'rails_helper'

RSpec.describe StockItemsController do
  before do
    @product = Product.create!(name: Faker::App.name, price: rand(1.00..2000.00))
    @store = Store.create!(name: Faker::App.name, address: Faker::Address.street_address)
    @stock_item = StockItem.create!(quantity: rand(100..200), product_id: @product.id, store_id: @store.id)
  end

  it 'should get index' do
    get :index, format: :json
    expect(response).to have_http_status(200)
  end

  it 'should create stock' do
    post :create, params: { quantity: rand(1..200), product_id: @product.id, store_id: @store.id }, format: :json
    expect(response).to have_http_status(201)
  end

  it 'should show stock' do
    get :show, params: { id: @stock_item.id }, format: :json
    expect(response).to have_http_status(200)
  end

  it 'should increase stock quantity' do
    previous_quantity = @stock_item.quantity
    to_increase = rand(1..100)

    patch :update, params: { id: @stock_item.id, quantity_add: to_increase }, format: :json
    updated_stock = StockItem.find(@stock_item.id)

    expect(response).to have_http_status(200)
    expect(updated_stock.quantity).to eq(previous_quantity + to_increase)
  end

  it 'should decrease stock quantity' do
    previous_quantity = @stock_item.quantity
    to_decrease = rand(1..100)

    patch :update, params: { id: @stock_item.id, quantity_take: to_decrease }, format: :json
    updated_stock = StockItem.find(@stock_item.id)
    
    expect(response).to have_http_status(200)
    expect(updated_stock.quantity).to eq(previous_quantity - to_decrease)
  end

  it 'should destroy stock' do
    delete :destroy, params: { id: @stock_item.id }, format: :json
    expect(response).to have_http_status(204)
  end
end