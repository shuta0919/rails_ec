class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find_by(id: params[:product_id])
    @cart_item = @cart.add_product(product)
    redirect_to root_path
  end

  def update
  end

  def destroy
  end



end
