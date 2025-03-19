class AddOrderToDeliveryAddresses < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:delivery_addresses, :order_id)
      add_reference :delivery_addresses, :order, null: false, foreign_key: true
    end
  end
end
