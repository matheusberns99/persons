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

ActiveRecord::Schema[8.0].define(version: 2025_03_23_182749) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "person_addresses", force: :cascade do |t|
    t.string "street", limit: 255, null: false
    t.string "city", limit: 255, null: false
    t.string "state", limit: 255, null: false
    t.integer "postal_code", null: false
    t.string "country", limit: 255, null: false
    t.bigint "person_id", null: false
    t.boolean "active", default: true
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_person_addresses_on_active"
    t.index ["deleted_at"], name: "index_person_addresses_on_deleted_at"
    t.index ["person_id"], name: "index_person_addresses_on_person_id"
  end

  create_table "persons", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "phone", limit: 255, null: false
    t.date "birthdate", null: false
    t.boolean "active", default: true
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_persons_on_active"
    t.index ["birthdate"], name: "index_persons_on_birthdate"
    t.index ["deleted_at"], name: "index_persons_on_deleted_at"
    t.index ["email"], name: "index_persons_on_email"
    t.index ["name"], name: "index_persons_on_name"
    t.index ["phone"], name: "index_persons_on_phone"
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

  add_foreign_key "person_addresses", "persons"
end
