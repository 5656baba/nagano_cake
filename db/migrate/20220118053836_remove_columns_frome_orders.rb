class RemoveColumnsFromeOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :Orders, :"name", :string
    remove_column :Orders, :"address", :string
  end
end
