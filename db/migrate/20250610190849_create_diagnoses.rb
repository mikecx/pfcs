class CreateDiagnoses < ActiveRecord::Migration[8.0]
  def change
    create_table :diagnoses do |t|
      t.string :resource_id, null: false, index: { unique: true }

      t.json :meta
      t.integer :status, default: 0
      t.json :coding
      t.string :appointment_reference

      t.timestamps
    end
  end
end
