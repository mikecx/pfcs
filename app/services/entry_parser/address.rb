# frozen_string_literal: true

module EntryParser
  class Address
    method_object [ :resource!, :address! ]

    def call
      use = address[:use]
      lines = address[:line].is_a?(Array) ? address[:line].join(" ") : address[:line]

      existing_address = resource.addresses.find_by(use:)

      if existing_address.present?
        existing_address.update(lines:)
      end

      resource.addresses.create!(use:, lines:) unless existing_address
    end
  end
end
