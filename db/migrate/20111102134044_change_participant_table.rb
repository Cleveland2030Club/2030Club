class ChangeParticipantTable < ActiveRecord::Migration
  def self.up
  	change_column :participants, :benefit, :text, :limit => false
  	change_column :participants, :instructions, :text, :limit => false
  end

  def self.down
  	change_column :participants, :instructions, :string
  	change_column :participants, :benefit, :text
  end
end
