# frozen_string_literal: true

class CarMaintenance < ApplicationRecord
  belongs_to :car

  validates :description, presence: true
  validate :date_is_now_or_in_the_past, on: :create

  enum status: %i[pending in_progress completed]

  private

  def date_is_now_or_in_the_past
    errors.add(:date, 'Must be a present date or in the past') if date.present? && date > Time.current
  end
end
