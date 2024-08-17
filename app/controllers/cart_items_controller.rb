class CartItemsController < ApplicationController
  def create
    @cart = current_cart
    product = Product.find_by(id: params[:product_id])
    @cart_item = @cart.add_product(product)
    redirect_to root_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:success] = '商品数量が更新されました'
      redirect_to cart_path
    else
      flash[:error] = '商品数量の更新に失敗しました'
      redirect_to cart_path
    end
  end

  def destroy
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end



end
