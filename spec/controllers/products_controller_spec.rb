require 'rails_helper'

RSpec.describe ProductsController do
  before do
    @product = Product.create!(name: Faker::App.name, price: rand(1.00...2000.00))
  end

  it 'should get index' do
    get :index, format: :json
    expect(response).to have_http_status(200)
  end

  it 'should create product' do
    post :create, params: { product: { name: Faker::App.name, price: rand(1.00...2000.00) } }, format: :json
    expect(response).to have_http_status(201)
  end

  it 'should show product' do
    get :show, params: { id: @product.id }, format: :json
    expect(response).to have_http_status(200)
  end

  it 'should update product' do
    patch :update, params: { id: @product.id, product: { name: Faker::App.name } }, format: :json
    expect(response).to have_http_status(200)
  end

  it 'should destroy product' do
    delete :destroy, params: { id: @product.id }, format: :json
    expect(response).to have_http_status(204)
  end
end
