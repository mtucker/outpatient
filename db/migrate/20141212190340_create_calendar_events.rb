class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.references :user, index: true
      t.string :type
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
