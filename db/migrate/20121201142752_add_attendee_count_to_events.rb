class AddAttendeeCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :attendee_count, :integer, default: 0, null: false
  end
end
