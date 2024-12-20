# frozen_string_literal: true

class CarSerializer < ActiveModel::Serializer
  attributes :id, :plate_number, :model, :year
end
