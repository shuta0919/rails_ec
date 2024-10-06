# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true
  validates :address_line_1, presence: true
  validates :country, presence: true
  validates :state, presence: true
  validates :zip, presence: true, format: { with: /\A\d{3}-?\d{4}\z/ }
  validates :cc_name, presence: true
  validates :cc_number, presence: true, format: { with: /\A\d{14,16}\z/ }
  validates :cc_exp, presence: true, format: { with: %r{\A(0[1-9]|1[0-2])/\d{2}\z} }
  validates :cc_cvv, presence: true, format: { with: /\A\d{3,4}\z/ }

  def full_name
    "#{last_name} #{first_name}"
  end
end
