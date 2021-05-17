class StoresController < ApplicationController
  before_action :set_store, only: %i[ show update destroy ]

  def_param_group :store_get do
    param :store, Hash, :required => true do
      param :id, :number, desc: 'Store id'	  
      param :name, String, :required => true, desc: 'Store name'
      param :address, String, :required => true, desc: 'Store address'
      param :created_at, Date, :required => true, desc: 'Date and time of the store creation'
      param :updated_at, Date, :required => true, desc: 'Date and time of the store last update'
      param :url, String, :required => true, desc: 'Url of the specific store'
    end
  end

  def_param_group :store_post do
    param :name, String, :required => true, desc: 'Store name'
    param :address, String, :required => true, desc: 'Store address'
    param :city, String, desc: 'Store city'
    param :country, String, desc: 'Store country'
  end

  def_param_group :store_patch do
    param :name, String, desc: 'Store name'
    param :address, String, desc: 'Store address'
    param :city, String, desc: 'Store city'
    param :country, String, desc: 'Store country'
  end

  api :GET, '/stores', 'Shows all stores'  
  returns array_of: :store_get, code: 200, desc: 'All stores' 

  def index
    @stores = Store.all
  end

  api :GET, '/stores/:id', 'Shows a specific store'  
  param :id, :number, desc: 'id of the requested store'
  returns array_of: :store_get, code: 200, desc: 'The specific store' 

  def show; end

  api :POST, "/stores", "Create a store"
  param_group :store_post
  returns array_of: :store_get, code: 201, desc: 'The new store' 

  def create
    @store = Store.new(store_params)

    if @store.save
      render :show, status: :created, location: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, "/stores/:id", "Updates a store"
  param :id, :number, desc: 'id of the requested store'
  param_group :store_patch
  returns array_of: :store_get, code: 200, desc: 'The updated store' 

  def update
    if @store.update(store_params)
      render :show, status: :ok, location: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "/stores/:id", "Deletes a store"
  param :id, :number, desc: 'id of the requested store'
  returns code: 204, desc: 'Successfull deletion of the store' 

  def destroy
    @store.destroy
  end

  private

    def set_store
      @store = Store.find(params[:id])
    end

    def store_params
      params.permit(:name, :address, :city, :country)
    end
end
