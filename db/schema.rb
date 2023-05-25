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

ActiveRecord::Schema[7.0].define(version: 2023_05_25_173125) do
  create_table "appointments", force: :cascade do |t|
    t.integer "window_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_appointments_on_user_id"
    t.index ["window_id"], name: "index_appointments_on_window_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "name"
    t.string "surname"
    t.string "patronymic"
    t.integer "phone_number", null: false
    t.integer "role", default: 0, null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "windows", force: :cascade do |t|
    t.datetime "datetime", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_windows_on_user_id"
  end

  add_foreign_key "appointments", "users"
  add_foreign_key "appointments", "windows"
  add_foreign_key "windows", "users"
end
