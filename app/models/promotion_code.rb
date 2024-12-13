class PromotionCode < ApplicationRecord
  has_many :orders, foreign_key: 'used_promotion_code_id'

  validates :code, presence: true,
                   uniqueness: true,
                   length: { is: 7 },
                   format: { with: /\A[A-Z0-9]+\z/ }

  validates :discount_amount, presence: true,
                              numericality: { only_integer: true,
                                              greater_than_or_equal_to: 100,
                                              less_than_or_equal_to: 1000 }

  def self.generate_code
    SecureRandom.alphanumeric(7).upcase
  end

  def self.generate_discount_amount
    rand(100..1000)
  end

end
