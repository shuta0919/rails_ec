# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  belongs_to :promotion_code, optional: true



  # 商品をカートに追加
  def add_product(product, quantity = 1)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += quantity
    else
      current_item = cart_items.build(product_id: product.id, quantity:)
    end
    current_item.save
    current_item
  end

  # カート内のアイテムの合計数
  def total_items
    cart_items.sum(:quantity)
  end

  # カート内のアイテムの合計金額
  def total_price
    cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  # プロモーションコードの割引額
  def discount_amount
    promotion_code&.discount_amount || 0
  end

  # プロモーションコードの割引後の合計金額
  def total_price_with_discount
    total_price - discount_amount
  end


end
