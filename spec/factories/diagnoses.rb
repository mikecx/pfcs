# frozen_string_literal: true

FactoryBot.define do
  factory :diagnosis do
    resource_id { "Diagnosis/#{SecureRandom.uuid}" }
    status { Diagnosis.statuses.values.sample }
  end
end
