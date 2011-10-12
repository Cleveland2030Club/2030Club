class CreateParticipantsTable < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name
      t.string :url
      t.text   :bio
      t.string :benefit
      t.string :instructions
      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
