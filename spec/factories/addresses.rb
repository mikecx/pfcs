# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    association :resource, factory: :patient, strategy: :build_stubbed

    use { Address.uses.values.sample }
    lines { Faker::Address.full_address }
  end
end
