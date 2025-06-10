class CreateDoctors < ActiveRecord::Migration[8.0]
  def change
    create_table :doctors do |t|
      t.string :resource_id, null: false, index: { unique: true }

      t.string :name
      t.string :given_name
      t.string :family_name

      t.timestamps
    end
  end
end
