# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:product)
    @order = Order.new
    @applied_promotion = PromotionCode.find_by(id: session[:promotion_code_id])
  end

  # プロモーションコードの適用
  def apply_promotion
    @cart = current_cart
    code = params[:promotion_code]
    promotion_code = PromotionCode.find_by(code: code, used: false)

    if promotion_code
      @cart.update(promotion_code: promotion_code)
      session[:promotion_code_id] = promotion_code.id
      flash[:success] = 'プロモーションコードが適用されました。'
      redirect_to cart_path
    else
      flash[:danger] = '無効なプロモーションコードです。'
      redirect_to cart_path
    end
  end



end
