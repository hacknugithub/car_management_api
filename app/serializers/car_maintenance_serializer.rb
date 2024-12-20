# frozen_string_literal: true

class CarMaintenanceSerializer < ActiveModel::Serializer
  attributes :id, :description, :status, :date

  belongs_to :car
end
