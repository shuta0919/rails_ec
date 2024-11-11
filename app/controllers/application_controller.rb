# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_cart

  # セッションの作成
  def current_cart
    Cart.find_by(id: session[:cart_id]) || create_new_cart
  end

  def create_new_cart
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.admin[:username] &&
        password == Rails.application.credentials.admin[:password]
    end
  end
end
