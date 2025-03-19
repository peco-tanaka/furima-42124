class RemoveOrderIdIdFromDeliveryAddresses < ActiveRecord::Migration[7.1]
  def change
    if column_exists?(:delivery_addresses, :order_id_id)
      remove_column :delivery_addresses, :order_id_id
    end
  end
end
