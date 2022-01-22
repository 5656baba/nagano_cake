class AddColumnsToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :customer_id, :integer
    add_column :items, :genre_id, :integer
    add_column :cart_items, :customer_id, :integer
    add_column :cart_items, :item_id, :integer
  end
end
