# frozen_string_literal: true

module DataProvider
  class Load
    method_object [ { file_path: "data/patient_feedback_raw_data.json" } ]

    def call
      absolute_path = Rails.root.join(file_path)
      raise Errno::ENOENT, "Data not found" unless File.exist?(absolute_path)

      ParseRecordsJob.perform_later(file_path:)
    end
  end
end
