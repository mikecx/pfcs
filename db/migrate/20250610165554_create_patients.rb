# frozen_string_literal: true

class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :resource_id, null: false, index: { unique: true }

      t.boolean :active, default: true
      t.string :name, null: false
      t.string :given_name
      t.string :family_name
      t.string :gender
      t.date :birth_date

      t.timestamps
    end
  end
end
