class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])

    @products = Product.where.not(id: @product.id).order(created_at: :desc).limit(4)
  end
end
