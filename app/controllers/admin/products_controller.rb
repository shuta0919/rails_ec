class Admin::ProductsController < ApplicationController
  def index
    @products = Product.with_attached_image
  end
end
