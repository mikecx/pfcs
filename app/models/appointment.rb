# frozen_string_literal: true

class Appointment < ApplicationRecord
  enum :status, { scheduled: 0, active: 1, finished: 2, cancelled: 3 }, prefix: true

  validates :resource_id, presence: true, uniqueness: true
  validates :period_start, presence: true
  validates :period_end, presence: true
  validate :end_time_after_start_time

  belongs_to :doctor, foreign_key: :actor_reference, primary_key: :resource_id, class_name: "Doctor", optional: true
  belongs_to :patient, foreign_key: :subject_reference, primary_key: :resource_id, class_name: "Patient", optional: true

  has_one :diagnosis, foreign_key: :appointment_reference, primary_key: :resource_id, class_name: "Diagnosis", dependent: :destroy
  has_one :feedback_response, dependent: :destroy

  def subject
    return nil if subject_reference.blank?

    Patient.find_by(resource_id: subject_reference)
  end

  def actor
    return nil if actor_reference.blank?

    ResourceLocater.call(id: actor_reference)
  end

  private

  def end_time_after_start_time
    return if period_start.blank? || period_end.blank?

    errors.add(:period_end, "must be after start time") if period_end <= period_start
  end
end
