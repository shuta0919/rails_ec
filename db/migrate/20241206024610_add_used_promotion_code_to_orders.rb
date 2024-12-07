class AddUsedPromotionCodeToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :used_promotion_code, foreign_key: { to_table: :promotion_codes }
  end
end
