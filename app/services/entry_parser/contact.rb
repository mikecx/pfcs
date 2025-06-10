# frozen_string_literal: true

module EntryParser
  class Contact
    method_object [ :resource!, :contact! ]

    def call
      value = contact[:value]
      system = contact[:system]
      use = contact[:use]

      existing_contact = resource.contacts.find_by(value:)

      if existing_contact.present?
        existing_contact.update(system:, use:)
      end

      resource.contacts.create!(system:, use:, value:) unless existing_contact
    end
  end
end
