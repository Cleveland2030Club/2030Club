class ChangeLocationsForRegionSelection < ActiveRecord::Migration
  def self.up
    change_table :locations do |t|
      t.remove :region
      t.column :region_id, :integer
      t.column :google_map_link, :string
    end
  end

  def self.down
    change_table :locations do |t|
      t.remove :google_map_link
      t.remove :region_id
      t.column :region, :string
    end
  end
end
