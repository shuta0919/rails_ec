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
      flash[:success] = "商品数量を更新しました"
      redirect_to cart_path
    else
      flash[:error] = "商品数量の更新に失敗しました"
      redirect_to cart_path
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])

    if @cart_item.destroy
      flash[:success] = "#{@cart_item.product.name}を削除しました"
      redirect_to cart_path
    else
      flash[:error] = "#{@cart_item.product.name}を削除できませんでした"
      redirect_to cart_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end



end
