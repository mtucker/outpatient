class AddDeletedAtToCalendarEvents < ActiveRecord::Migration
  def change
    add_column :calendar_events, :deleted_at, :datetime
    add_index :calendar_events, :deleted_at
  end
end
