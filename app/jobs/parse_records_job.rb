class ParseRecordsJob < ApplicationJob
  queue_as :default

  def perform(file_path:)
    absolute_path = Rails.root.join(file_path)
    records_json = JSON.parse(File.read(absolute_path), symbolize_names: true)

    entries = records_json[:entry]
    return nil if entries.nil? || entries.empty?

    entries.each do |entry|
      resource = entry[:resource]
      resource_id = entry.dig(:resource, :id)
      resource_type = entry.dig(:resource, :resourceType)

      case resource_type
      when "Patient"
        EntryParser::Patient.call(resource:)
      when "Doctor"
        EntryParser::Doctor.call(resource:)
      when "Appointment"
        EntryParser::Appointment.call(resource:)
      when "Diagnosis"
        EntryParser::Diagnosis.call(resource:)
      else
        Rails.logger.warn("Unsupported resource type: #{resource_type} for: #{resource_id}")
      end
    end
  rescue JSON::ParserError => e
    raise "Invalid JSON in #{file_path}: #{e.message}"
  end
end
