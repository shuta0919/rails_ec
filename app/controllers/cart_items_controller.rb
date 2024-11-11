# frozen_string_literal: true

class CartItemsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    @cart_item = current_cart.add_product(@product, quantity)

    if @cart_item.persisted?
      flash[:success] = "#{@product.name} をカートに追加しました"
      redirect_to root_path and return
    else
      flash[:danger] = 'カートに追加できませんでした'
      redirect_to @product and return
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:success] = '商品数量を更新しました'
    else
      flash[:danger] = '商品数量の更新に失敗しました'
    end
    redirect_to cart_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])

    if @cart_item.destroy
      flash[:success] = "#{@cart_item.product.name}を削除しました"
    else
      flash[:error] = "#{@cart_item.product.name}を削除できませんでした"
    end
    redirect_to cart_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
