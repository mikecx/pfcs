# frozen_string_literal: true

module EntryParser
  class Doctor
    method_object [ :resource! ]

    def call
      id = "Doctor/#{resource.dig(:id)}"
      family_name = resource.dig(:name, 0, :family)
      given = resource.dig(:name, 0, :given)

      given_name = given.is_a?(Array) ? given.join(" ") : given
      name = "#{given_name} #{family_name}".strip

      doctor = ::Doctor.find_or_initialize_by(resource_id: id)
      doctor.update!(name:, given_name:, family_name:)
    end
  end
end
