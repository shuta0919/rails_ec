class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :adress_line_1, null: false
      t.string :adress_line_2
      t.string :country, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :cc_name, null: false
      t.string :cc_number, null: false
      t.string :cc_exp, null: false
      t.string :cc_cvv, null: false

      t.timestamps
    end
  end
end
