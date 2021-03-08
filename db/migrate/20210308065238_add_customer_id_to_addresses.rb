class AddCustomerIdToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :name, :integer
  end
end
