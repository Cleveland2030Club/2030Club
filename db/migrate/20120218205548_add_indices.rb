class AddIndices < ActiveRecord::Migration
  def self.up
    add_index :items, :product_id
    add_index :items, :product_type
    add_index :locations, :participant_id
    add_index :locations, :region_id
    add_index :order_items, :order_id
    add_index :order_items, :item_id
    add_index :orders, :customer_id
    add_index :orders, :customer_type
    add_index :orders, :express_payer_id
    add_index :registrations, :user_id
  end

  def self.down
    remove_index :items, :product_id
    remove_index :items, :product_type
    remove_index :locations, :participant_id
    remove_index :locations, :region_id
    remove_index :order_items, :order_id
    remove_index :order_items, :item_id
    remove_index :orders, :customer_id
    remove_index :orders, :customer_type
    remove_index :orders, :express_payer_id
    remove_index :registrations, :user_id
  end
end
