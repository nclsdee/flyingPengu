# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_16_121951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hometowns", force: :cascade do |t|
    t.string "city"
    t.integer "number_traveller"
    t.date "date_from"
    t.date "date_to"
    t.json "results"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "direct"
    t.index ["city"], name: "index_hometowns_on_city"
    t.index ["date_from"], name: "index_hometowns_on_date_from"
    t.index ["date_to"], name: "index_hometowns_on_date_to"
    t.index ["number_traveller"], name: "index_hometowns_on_number_traveller"
    t.index ["trip_id"], name: "index_hometowns_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "hometowns", "trips"
  add_foreign_key "trips", "users"
end
