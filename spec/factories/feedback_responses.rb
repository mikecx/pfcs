# frozen_string_literal: true

FactoryBot.define do
  factory :feedback_response do
    association :appointment, strategy: :build_stubbed

    nps_score { Faker::Number.between(from: 1, to: 10) }
    management_understood { Faker::Boolean.boolean }
    management_feedback { Faker::Lorem.sentence }
    diagnosis_feedback { Faker::Lorem.sentence }
  end
end
