# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Car, type: :model do
  it 'is valid with valid attributes' do
    car = Car.new(plate_number: 'TRTYH340', model: 'Camry', year: 2022)
    expect(car).to be_valid
  end

  it 'is invalid if the plate_number is blank' do
    car = Car.new(plate_number: '', model: 'Camry', year: 2022)

    expect(car).not_to be_valid
    expect(car.errors[:plate_number]).to include("can't be blank")
  end

  it 'is invalid when duplicated plate_number' do
    Car.create(plate_number: 'TRTYH341', model: 'Camry', year: 2022)
    car = Car.new(plate_number: 'TRTYH341', model: 'Toyota', year: 2019)

    expect(car).not_to be_valid
    expect(car.errors[:plate_number]).to include('has already been taken')
  end

  it 'is invalid if the year is before 1900' do
    car = Car.new(plate_number: 'TRTYH342', model: 'Toyota', year: 1899)

    expect(car).not_to be_valid
    expect(car.errors[:year]).to include('must be greater than or equal to 1900')
  end

  it 'is invalid if the year is in the future' do
    current_year = Time.current.year
    future_year = Time.current.next_year.year
    car = Car.new(plate_number: 'TRTYH343', model: 'Toyota', year: future_year)

    expect(car).not_to be_valid
    expect(car.errors[:year]).to include("must be less than or equal to #{current_year}")
  end

  it 'is invalid if the year is not an integer' do
    car = Car.new(plate_number: 'TRTYH343', model: 'Toyota', year: 'not_a_number')

    expect(car).not_to be_valid
    expect(car.errors[:year]).to include('is not a number')
  end
end
