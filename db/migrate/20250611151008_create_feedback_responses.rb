# frozen_string_literal: true

class CreateFeedbackResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :feedback_responses do |t|
      t.references :appointment, null: false

      t.integer :nps_score, default: 1
      t.boolean :management_understood, default: false
      t.text :management_feedback
      t.text :diagnosis_feedback

      t.timestamps
    end
  end
end
