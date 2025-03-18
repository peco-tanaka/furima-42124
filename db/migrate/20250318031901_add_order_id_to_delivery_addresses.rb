class AddOrderIdToDeliveryAddresses < ActiveRecord::Migration[7.1]
  def change
    add_reference :delivery_addresses, :order, null: false, foreign_key: true
  end
end
