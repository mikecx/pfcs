class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.string :resource_id, null: false, index: { unique: true }

      t.integer :status, default: 0
      t.text :appointment_type
      t.string :subject_reference
      t.string :actor_reference
      t.datetime :period_start, null: false
      t.datetime :period_end, null: false

      t.timestamps
    end
  end
end
