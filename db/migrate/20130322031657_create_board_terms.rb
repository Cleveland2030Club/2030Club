class CreateBoardTerms < ActiveRecord::Migration
  def change
    create_table :board_terms do |t|
      t.belongs_to :user
      t.datetime :start_at
      t.datetime :end_at
      t.integer :position

      t.timestamps
    end
    add_index :board_terms, :user_id
  end
end
