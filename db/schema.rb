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

ActiveRecord::Schema[8.0].define(version: 2025_07_10_231247) do
  create_table "car_models", force: :cascade do |t|
    t.string "brand", null: false
    t.string "name", null: false
    t.string "car_category", null: false
    t.date "year", null: false
    t.integer "fuel_type", null: false
    t.integer "transmission", null: false
    t.string "engine", null: false
    t.integer "doors_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.integer "car_model_id", null: false
    t.string "color", null: false
    t.string "license_plate", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.integer "mileage", null: false
    t.integer "price", null: false
    t.datetime "fabricated_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code", null: false
    t.index ["car_model_id"], name: "index_cars_on_car_model_id"
  end

  add_foreign_key "cars", "car_models"
end
