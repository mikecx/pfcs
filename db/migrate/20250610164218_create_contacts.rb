# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.integer :system, default: 0
      t.string :value, null: false
      t.integer :use, default: 0

      t.references :resource, polymorphic: true, null: false

      t.timestamps
    end
  end
end
