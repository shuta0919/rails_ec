class RenameDiscountAmontColumnInPromotionCodes < ActiveRecord::Migration[7.0]
  def change
    rename_column :promotion_codes, :discount_amont, :discount_amount
  end
end
