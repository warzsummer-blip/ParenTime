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

ActiveRecord::Schema[7.1].define(version: 2026_09_13_075336) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendees", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id"
    t.bigint "confirmed_candidate_id"
    t.string "parent_name", null: false
    t.string "child_name", null: false
    t.string "grade_class", null: false
    t.string "sibling_info"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmed_candidate_id"], name: "index_attendees_on_confirmed_candidate_id"
    t.index ["event_id"], name: "index_attendees_on_event_id"
    t.index ["user_id"], name: "index_attendees_on_user_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_candidates_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "slot_duration", default: 15, null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_events_on_token", unique: true
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "attendee_id", null: false
    t.bigint "candidate_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendee_id", "candidate_id"], name: "index_responses_on_attendee_id_and_candidate_id", unique: true
    t.index ["attendee_id"], name: "index_responses_on_attendee_id"
    t.index ["candidate_id"], name: "index_responses_on_candidate_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendees", "candidates", column: "confirmed_candidate_id"
  add_foreign_key "attendees", "events"
  add_foreign_key "attendees", "users"
  add_foreign_key "candidates", "events"
  add_foreign_key "events", "users"
  add_foreign_key "responses", "attendees"
  add_foreign_key "responses", "candidates"
end
