# frozen_string_literal: true

class ResourceLocater
  LOCATABLE_RESOURCES = %i[Appointment Doctor Diagnosis Patient].freeze

  method_object [ :id! ]

  def call
    resource_class, resource_id = id.split("/")
    raise ArgumentError, "Resource class not found for ID: #{id}" unless resource_class && resource_id && LOCATABLE_RESOURCES.include?(resource_class.to_sym)

    resource = resource_class.classify.constantize.find_by(resource_id: id)
    raise ActiveRecord::RecordNotFound, "#{resource_class} not found with resource id: #{resource_id}" unless resource

    resource
  end
end
