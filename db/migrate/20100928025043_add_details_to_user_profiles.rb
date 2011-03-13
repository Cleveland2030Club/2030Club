class AddDetailsToUserProfiles < ActiveRecord::Migration
  def self.up
    add_column :user_profiles, :gender, :string, :limit => 1
    add_column :user_profiles, :member_notes, :text
  end

  def self.down
    remove_column :user_profiles, :member_notes
    remove_column :user_profiles, :gender
  end
end
