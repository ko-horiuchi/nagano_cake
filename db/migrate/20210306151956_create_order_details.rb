class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :price
      t.integer :amount

      t.timestamps
    end
  end
end
