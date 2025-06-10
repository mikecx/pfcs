# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.integer :use, default: 0
      t.text :lines, null: false
      t.references :resource, polymorphic: true, null: false

      t.timestamps
    end
  end
end
