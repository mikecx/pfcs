# frozen_string_literal: true

module EntryParser
  class Diagnosis
    method_object [ :resource! ]

    def call
      id = resource.dig(:id)
      meta = resource.dig(:meta)
      status = resource.dig(:status)
      coding = resource.dig(:code, :coding)
      appointment_reference = resource.dig(:appointment, :reference)

      diagnosis = ::Diagnosis.find_or_initialize_by(resource_id: id)
      diagnosis.update!(meta:, status:, coding:, appointment_reference:)
    end
  end
end
