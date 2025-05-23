# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate, only: %i[index, show]

  def create
    @order = Order.new(order_params)


      ActiveRecord::Base.transaction do
      apply_promotion_code
      @order.save!
      create_order_items
      mark_promotion_code_used
      delete_cart
    end

      OrderMailer.order_confirmation(@order).deliver_later
      flash[:success] = '購入ありがとうございます'
      redirect_to root_path

    rescue => e
      @cart = current_cart
      @cart_items = @cart.cart_items
      flash.now[:danger] = '購入に失敗しました。エラーを確認してください。'
      render 'carts/show', status: :unprocessable_entity
  end

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :address_line_1, :address_line_2, :country, :state,
                                  :zip, :cc_name, :cc_number, :cc_exp, :cc_cvv)
  end

  def apply_promotion_code
    @order.used_promotion_code = current_cart.promotion_code if current_cart.promotion_code
  end

  def mark_promotion_code_used
    @order.used_promotion_code.update!(used: true) if @order.used_promotion_code
  end

  def create_order_items
    current_cart.cart_items.each do |cart_item|
      @order.order_items.create!(
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
