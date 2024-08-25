# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(:product)
  end
end
