# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    association :resource, factory: :patient, strategy: :build_stubbed

    system { Contact.systems.values.sample }
    value { Faker::Internet.email }
    use { Contact.uses.values.sample }
  end
end
