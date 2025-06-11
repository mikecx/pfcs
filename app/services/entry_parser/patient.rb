# frozen_string_literal: true

module EntryParser
  class Patient
    method_object [ :resource! ]

    def call
      id = "Patient/#{resource.dig(:id)}"

      active = resource.dig(:active)
      name = resource.dig(:name, 0, :text)
      given_name = resource.dig(:name, 0, :given)
      family_name = resource.dig(:name, 0, :family)
      gender = resource.dig(:gender)
      birth_date = resource.dig(:birthDate)

      patient = ::Patient.find_or_initialize_by(resource_id: id) do |patient_record|
        patient_record.active = active
        patient_record.name = name
        patient_record.given_name = given_name.is_a?(Array) ? given_name.join(" ") : given_name
        patient_record.family_name = family_name
        patient_record.gender = gender
        patient_record.birth_date = birth_date.is_a?(String) ? Date.parse(birth_date) : birth_date
      end

      if patient.valid?
        patient.save

        resource[:contact].each do |contact|
          EntryParser::Contact.call(resource: patient, contact:)
        end

        resource[:address].each do |address|
          EntryParser::Address.call(resource: patient, address:)
        end
      else
        Rails.logger.error("Invalid patient data: #{patient.errors.full_messages.join(', ')}")
      end
    end
  end
end
