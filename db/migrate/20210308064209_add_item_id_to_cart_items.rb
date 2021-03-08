class AddItemIdToCartItems < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :name, :integer
  end
end
