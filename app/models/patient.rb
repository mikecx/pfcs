# frozen_string_literal: true

class Patient < ApplicationRecord
  validates :resource_id, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :contacts, as: :resource, dependent: :destroy
  has_many :addresses, as: :resource, dependent: :destroy

  def appointments
    Appointment.where(subject_reference: resource_id)
  end
end
