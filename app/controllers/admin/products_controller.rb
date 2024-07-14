class Admin::ProductsController < ApplicationController
  before_action :authenticate

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
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:success] = "#{@product.name}が更新されました"
      redirect_to admin_products_path
    else
      flash[:error] = "#{@product.name}の更新に失敗しました。入力内容を確認してください。"
      render :edit
    end
  end


  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      flash[:success] = "#{@product.name}が正常に削除されました"
      redirect_to admin_products_path
    else
      flash[:error] = "#{@product.name}の削除に失敗しました"
      redirect_to admin_products_path
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic do |username, password |
      username == Rails.application.credentials.admin[:username] &&
      password == Rails.application.credentials.admin[:password]
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image)
  end
end
