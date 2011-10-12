class AddCategoryColumnToParticipants < ActiveRecord::Migration
  def self.up
    add_column :participants, :category_id, :integer
  end

  def self.down
    remove_column :participants, :category_id
  end
end
