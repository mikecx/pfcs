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

ActiveRecord::Schema[8.0].define(version: 2025_06_11_151008) do
  create_table "addresses", force: :cascade do |t|
    t.integer "use", default: 0
    t.text "lines", null: false
    t.string "resource_type", null: false
    t.integer "resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_addresses_on_resource"
  end

  create_table "appointments", force: :cascade do |t|
    t.string "resource_id", null: false
    t.integer "status", default: 0
    t.text "appointment_type"
    t.string "subject_reference"
    t.string "actor_reference"
    t.datetime "period_start", null: false
    t.datetime "period_end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_appointments_on_resource_id", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "system", default: 0
    t.string "value", null: false
    t.integer "use", default: 0
    t.string "resource_type", null: false
    t.integer "resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_type", "resource_id"], name: "index_contacts_on_resource"
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string "resource_id", null: false
    t.json "meta"
    t.integer "status", default: 0
    t.json "coding"
    t.string "appointment_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_diagnoses_on_resource_id", unique: true
  end

  create_table "doctors", force: :cascade do |t|
    t.string "resource_id", null: false
    t.string "name"
    t.string "given_name"
    t.string "family_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_doctors_on_resource_id", unique: true
  end

  create_table "feedback_responses", force: :cascade do |t|
    t.integer "appointment_id", null: false
    t.integer "nps_score", default: 1
    t.boolean "management_understood", default: false
    t.text "management_feedback"
    t.text "diagnosis_feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_feedback_responses_on_appointment_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "resource_id", null: false
    t.boolean "active", default: true
    t.string "name", null: false
    t.string "given_name"
    t.string "family_name"
    t.string "gender"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_patients_on_resource_id", unique: true
  end
end
