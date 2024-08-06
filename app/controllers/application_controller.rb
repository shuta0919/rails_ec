# frozen_string_literal: true

class ApplicationController < ActionController::Base
  

  # セッションの作成
  def current_cart
    current_cart = Cart.find_by(id: session[:id])
    current_cart = Cart.create unless current_cart
    session[:cart_id] = current_cart.id
    return current_cart
  end
end
