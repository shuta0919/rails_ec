# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :authenticate
    before_action :set_product, only: %i[edit update destroy]

    def index
      @products = Product.with_attached_image.order(created_at: :desc).page(params[:page]).per(12)
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        flash[:success] = "#{@product.name}が登録されました"
        redirect_to admin_products_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @product.update(product_params)
        flash[:success] = "#{@product.name}が更新されました"
        redirect_to admin_products_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @product.destroy
        flash[:success] = "#{@product.name}が正常に削除されました"
      else
        flash[:danger] = "#{@product.name}の削除に失敗しました"
      end
      redirect_to admin_products_path
    end

    private

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == Rails.application.credentials.admin[:username] &&
          password == Rails.application.credentials.admin[:password]
      end
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image)
    end

    def set_product
      @product = Product.find(params[:id])
    end
  end
end
