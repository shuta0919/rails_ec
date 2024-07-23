# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.with_attached_image.order(created_at: :desc).page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])

    @products = Product.with_attached_image.where.not(id: @product.id).order(created_at: :desc).limit(4)
  end
end
