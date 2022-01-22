class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :delivery_postal_code
      t.string :address
      t.string :name
      t.integer :sipping_fee
      t.integer :billing_amount
      t.integer :payment_method
      t.integer :order_status

      t.timestamps
    end
  end
end
