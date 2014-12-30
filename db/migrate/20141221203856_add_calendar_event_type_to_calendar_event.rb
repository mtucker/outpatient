class AddCalendarEventTypeToCalendarEvent < ActiveRecord::Migration
  def change
    add_reference :calendar_events, :calendar_event_type, index: true
  end
end
