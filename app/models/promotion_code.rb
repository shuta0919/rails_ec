class PromotionCode < ApplicationRecord
  validates :code, presence: true,
                   uniqueness: true,
                   length: { is: 7 },
                   format: { with: /\A[A-Z0-9]+\z/ }

  validates :discount_amount, presence: true,
                              numericality: { onliy_integer: true,
                                              greather_than_or_equal_to: 100,
                                              less_than_or_equal_to: 1000 }

  def self.generate_code
end
