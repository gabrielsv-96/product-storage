require 'rails_helper'

RSpec.describe StoresController do
  before do
    @store = Store.create!(name: Faker::App.name, address: Faker::Address.street_address)
  end

  it 'should get index' do
    get :index, as: :json
    expect(response).to have_http_status(200)
  end

  it 'should create store' do
    post :create, params: { name: Faker::App.name, address: Faker::Address.street_address }, as: :json
    expect(response).to have_http_status(201)
  end

  it 'should show store' do
    get :show, params: { id: @store.id }, as: :json
    expect(response).to have_http_status(200)
  end

  it 'should update store' do
    patch :update, params: { id: @store.id, name: Faker::App.name }, as: :json
    expect(response).to have_http_status(200)
  end

  it 'should destroy store' do
    delete :destroy, params: { id: @store.id }, as: :json
    expect(response).to have_http_status(204)
  end
end