class CreateCalendarEventTypes < ActiveRecord::Migration
  def change
    create_table :calendar_event_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
