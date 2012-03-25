class AddLastRenewedAtToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_renewed_at, :datetime
  end

  def self.down
    remove_column :users, :last_renewed_at
  end
end
