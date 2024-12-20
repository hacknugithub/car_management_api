# frozen_string_literal: true

class Car < ApplicationRecord
  validates :plate_number, presence: true, uniqueness: true
  validates :year,
            numericality: { only_integer: true, greater_than_or_equal_to: 1900,
                            less_than_or_equal_to: Time.current.year }
end
