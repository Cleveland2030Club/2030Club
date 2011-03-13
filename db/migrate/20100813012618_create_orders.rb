class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :customer_id, :null => false
      t.string  :customer_type, :null => false
      t.decimal :amount, :null => false, :precision => 8, :scale => 2
      t.string  :express_token
      t.string  :express_payer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end

