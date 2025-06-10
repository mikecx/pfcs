# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    resource_id { "Appointment/#{SecureRandom.uuid}" }
    status { Appointment.statuses.values.sample }
    appointment_type { "Wellness check" }
    period_start { 72.hours.ago }
    period_end { 71.hours.ago }
  end
end
