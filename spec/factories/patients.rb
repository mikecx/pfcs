# frozen_string_literal: true

FactoryBot.define do
  factory :patient do
    resource_id { "Patient/#{SecureRandom.uuid}" }
    active { Faker::Boolean.boolean }
    name { Faker::Name.name }
    given_name { Faker::Name.name.split(' ').first }
    family_name { Faker::Name.name.split(' ').last }
    gender { Faker::Gender.type }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
