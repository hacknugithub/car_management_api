# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_241_220_163_823) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'car_maintenances', force: :cascade do |t|
    t.bigint 'car_id', null: false
    t.string 'description'
    t.integer 'status'
    t.datetime 'date'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['car_id'], name: 'index_car_maintenances_on_car_id'
  end

  create_table 'cars', force: :cascade do |t|
    t.string 'plate_number'
    t.string 'model'
    t.integer 'year'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'car_maintenances', 'cars'
end
