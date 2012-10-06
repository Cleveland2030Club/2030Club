class RemoveAddressTypeIdFromUserAddresses < ActiveRecord::Migration
  def up
    change_table :user_addresses do |t|
      t.remove :address_type_id
      t.remove :is_primary
    end
  end

  def down
    change_table :user_addresses do |t|
      t.integer :address_type_id
      t.boolean :is_primary
    end
  end
end
