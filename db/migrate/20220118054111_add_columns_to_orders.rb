class AddColumnsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :delivery_name, :string
    add_column :orders, :delivery_address, :string
  end
end
