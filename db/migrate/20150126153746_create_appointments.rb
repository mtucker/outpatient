class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :calendar_event, index: true
      t.integer    :provider_id
      t.references :user, index: true

      t.timestamps null: false
    end

    add_index :appointments, :provider_id

    add_foreign_key :appointments, :calendar_events
    add_foreign_key :appointments, :users, column: :provider_id
    add_foreign_key :appointments, :users
  end
end
