class Admin::ProductsController < ApplicationController
  def index
    @products = Product.with_attached_image
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
      flash[:error] = "商品の登録に失敗しました"
      redirect_to new_admin_product_path
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
