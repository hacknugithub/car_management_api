# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    plate_number { Faker::DrivingLicence.usa_driving_licence }
    model { Faker::Space.moon }
    year { Faker::Number.between(from: 1900, to: Time.current.year) }

    trait :with_car_maintenances do
      after(:create) do |instance|
        create_list :car_maintenance, 5, car: instance
      end
    end
  end
end
