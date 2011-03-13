class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.integer :product_id, :null => false
      t.string  :product_type, :null => false
      t.string  :name, :null => false
      t.decimal :price, :null => false, :precision => 8, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
