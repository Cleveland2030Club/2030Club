class CreateLocationsTable < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :participant_id
      t.string  :region
      t.string  :address
      t.string  :address_cont
      t.string  :city
      t.string  :state
      t.string  :zip
      t.string  :phone
    end
  end

  def self.down
    drop_table :locations
  end
end
