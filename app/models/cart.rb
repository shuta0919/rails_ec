class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  # 商品をカートに追加
  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
      current_item.save
    else
      current_item = cart_items.create(product_id: product.id, quantity: 1)
    end
    return current_item
  end

  # カート内のアイテムの合計数
  def total_items
    cart_items.sum(:quantity)
  end

  # カート内のアイテムの合計金額
  def total_price
    cart_items.sum{ |item| item.product.price * item.quantity }
  end


end
