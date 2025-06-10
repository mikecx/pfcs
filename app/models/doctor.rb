# frozen_string_literal: true

class Doctor < ApplicationRecord
  validates :resource_id, presence: true, uniqueness: true
  validates :name, presence: true

  def appointments
    Appointment.where(actor_reference: resource_id)
  end
end
