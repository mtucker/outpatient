class ChangeCalendarEventTypeToType < ActiveRecord::Migration
  def change
    add_column :calendar_events, :type, :string
    add_index :calendar_events, :type
    remove_column :calendar_events, :calendar_event_type_id
  end
end
