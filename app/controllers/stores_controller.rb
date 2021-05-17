class StoresController < ApplicationController
  before_action :set_store, only: %i[ show update destroy ]

  def index
    @stores = Store.all
  end

  def show; end

  def create
    @store = Store.new(store_params)

    if @store.save
      render :show, status: :created, location: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

  def update
    if @store.update(store_params)
      render :show, status: :ok, location: @store
    else
      render json: @store.errors, status: :unprocessable_entity
    end
  end

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
