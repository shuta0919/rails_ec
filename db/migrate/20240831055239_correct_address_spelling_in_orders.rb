class CorrectAddressSpellingInOrders < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :addres_line_1, :address_line_1
    rename_column :orders, :addres_line_2, :address_line_2
  end
end
