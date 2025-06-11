# frozen_string_literal: true

module EntryParser
  class Appointment
    method_object [ :resource! ]

    def call
      id = "Appointment/#{resource.dig(:id)}"

      status = resource.dig(:status)
      type = resource.dig(:type)
      subject_reference = resource.dig(:subject, :reference)
      actor_reference = resource.dig(:actor, :reference)
      period_start = resource.dig(:period, :start)
      period_end = resource.dig(:period, :end)

      if type.is_a?(Array)
        appointment_type = type.map { |item| item[:text] }.join(", ")
      else
        appointment_type = type
      end

      appointment = ::Appointment.find_or_initialize_by(resource_id: id)
      appointment.update!(status:, appointment_type:, subject_reference:, actor_reference:, period_start:, period_end:)
    end
  end
end
