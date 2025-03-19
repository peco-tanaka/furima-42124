class RemoveOrderIdIdFromDeliveryAddresses < ActiveRecord::Migration[7.1]
  def change
    remove_column :delivery_addresses, :order_id_id
  end
end
