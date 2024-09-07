class OrdersController < ApplicationController

  def create
    @order = Order.new(order_params)
    if @order.save
      create_order_items
      delete_cart
      flash[:success] = '購入ありがとうございます'
      redirect_to root_path
    else
      flash[:danger] = '購入失敗しました'
      redirect_to cart_path
    end
  end

  

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :address_line_1, :address_line_2, :country, :state, :zip, :cc_name, :cc_number, :cc_exp, :cc_cvv)
  end

  def create_order_items
    current_cart.cart_items.each do |cart_item|
      @order.order_items.create(
        product: cart_item.product,
        quantity: cart_item.quantity,
        price: cart_item.product.price,
        total_price: cart_item.total_price
      )
    end
  end

  def delete_cart
    current_cart.destroy
    session[:cart_id] = nil
  end
end
