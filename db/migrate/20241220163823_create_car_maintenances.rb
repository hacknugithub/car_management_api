# frozen_string_literal: true

class CreateCarMaintenances < ActiveRecord::Migration[6.1]
  def change
    create_table :car_maintenances do |t|
      t.references :car, null: false, foreign_key: true
      t.string :description
      t.integer :status
      t.datetime :date

      t.timestamps
    end
  end
end
