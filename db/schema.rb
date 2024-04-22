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

ActiveRecord::Schema[7.1].define(version: 2024_04_22_042059) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_weathers", force: :cascade do |t|
    t.float "temperature"
    t.float "feels_like"
    t.float "humidity"
    t.float "visibility"
    t.string "condition"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_weathers", force: :cascade do |t|
    t.string "date"
    t.string "sunrise"
    t.string "sunset"
    t.float "max_temp"
    t.float "min_temp"
    t.string "condition"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forecasts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hourly_weathers", force: :cascade do |t|
    t.string "time"
    t.float "temperature"
    t.string "conditions"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
