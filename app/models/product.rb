# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  validates :price, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  has_one_attached :image
  has_many :cart_items
  has_many :carts, through: :cart_items
end
