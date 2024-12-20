# frozen_string_literal: true

FactoryBot.define do
  factory :car_maintenance do
    car { FactoryBot.create(:car) }
    description { Faker::Lorem.paragraph }
    status { Faker::Number.between(from: 0, to: 2) }
    date { Faker::Date.backward(days: 1) }
  end
end
