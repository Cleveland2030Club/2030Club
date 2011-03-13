class AddColumnToEventsTable < ActiveRecord::Migration
  def self.up
    change_table :events do |t|  
      t.column :url_friendly,         :string
      t.column :description,          :text
      t.column :sponsored,            :boolean
      t.column :max_attendance,       :integer
      t.column :sponsor_file_name,    :string
      t.column :sponsor_content_type, :string
      t.column :sponsor_file_size,    :integer
      t.column :sponsor_updated_at,   :datetime
    end
  end

  def self.down
    change_table :events do |t|
      t.remove :sponsored_updated_at
      t.remove :sponsor_file_size
      t.remove :sponsor_content_type
      t.remove :sponsor_file_name
      t.remove :max_attendance
      t.remove :sponsored
      t.remove :description
      t.remove :url_friendly
    end
  end
end
