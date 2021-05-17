class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]

  def_param_group :product_get do
    param :product, Hash, :required => true do
      param :id, :number, desc: 'Product id'	  
      param :name, String, :required => true, desc: 'Product name'
      param :price, Float, :required => true, desc: 'Product price'
      param :brand, String, desc: 'Product brand'
      param :created_at, Date, :required => true, desc: 'Date and time of the product creation'
      param :updated_at, Date, :required => true, desc: 'Date and time of the product last update'
      param :url, String, :required => true, desc: 'Url of the specific product'
    end
  end

  def_param_group :product_post do
    param :name, String, :required => true, desc: 'Product name'
    param :price, Float, :required => true, desc: 'Product price'
    param :brand, String, desc: 'Product brand'
  end

  def_param_group :product_patch do
    param :name, String, desc: 'Product name'
    param :price, Float, desc: 'Product price'
    param :brand, String, desc: 'Product brand'
  end

  api :GET, '/products', 'Shows all products'  
  returns array_of: :product_get, code: 200, desc: 'All products' 

  def index
    @products = Product.all
  end

  api :GET, '/products/:id', 'Shows a specific product'  
  param :id, :number, desc: 'id of the requested product'
  returns array_of: :product_get, code: 200, desc: 'The specific product' 

  def show; end

  api :POST, "/products", "Create a product"
  param_group :product_post
  returns array_of: :product_get, code: 201, desc: 'The new product' 

  def create
    @product = Product.new(product_params)

    if @product.save
      render :show, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  api :PATCH, "/products/:id", "Updates a product"
  param :id, :number, desc: 'id of the requested product'
  param_group :product_patch
  returns array_of: :product_get, code: 200, desc: 'The updated product' 

  def update
    if @product.update(product_params)
      render :show, status: :ok, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  api :DELETE, "/products/:id", "Deletes a product"
  param :id, :number, desc: 'id of the requested product'
  returns code: 204, desc: 'Successfull deletion of the product' 

  def destroy
    @product.destroy
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.permit(:name, :price, :brand)
    end
end
