# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CarMaintenance, type: :model do
  let(:car) { FactoryBot.create :car }

  it 'is valid with valid attributes' do
    car_maintenance = CarMaintenance.new(
      car_id: car.id,
      description: 'Lorem ipsum',
      status: :pending,
      date: Time.current
    )
    expect(car_maintenance).to be_valid
  end

  it 'is invalid when car_is is not present' do
    car_maintenance = CarMaintenance.new(
      car_id: '',
      description: 'Lorem ipsum',
      status: :pending,
      date: Time.current
    )
    expect(car_maintenance).not_to be_valid
  end

  it 'is invalid when date is in the future' do
    car_maintenance = CarMaintenance.new(
      car_id: car.id,
      description: 'Lorem ipsum',
      status: :pending,
      date: Time.current.advance(days: 1)
    )
    expect(car_maintenance).not_to be_valid
  end
end
