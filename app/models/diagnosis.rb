# frozen_string_literal: true

class Diagnosis < ApplicationRecord
  enum :status, { final: 0 }, prefix: true

  validates :resource_id, presence: true, uniqueness: true

  belongs_to :appointment, foreign_key: :appointment_reference, primary_key: :resource_id, class_name: "Appointment", optional: true

  def human_readable
    return "" if coding.blank?

    coding&.map do |code|
      code["name"] || ""
    end.join(", ")
  end
end
