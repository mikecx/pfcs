# frozen_string_literal: true

class Diagnosis < ApplicationRecord
  enum :status, { final: 0 }, prefix: true

  validates :resource_id, presence: true, uniqueness: true

  def appointment
    return nil unless appointment_reference.present?

    ResourceLocater.call(id: appointment_reference)
  end
end
