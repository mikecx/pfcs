# frozen_string_literal: true

FactoryBot.define do
  factory :doctor do
    resource_id { "Doctor/#{SecureRandom.uuid}" }
    name { Faker::Name.name }
    given_name { Faker::Name.name.split(' ').first }
    family_name { Faker::Name.name.split(' ').last }
  end
end
