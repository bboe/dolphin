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

ActiveRecord::Schema[8.1].define(version: 2026_06_15_160637) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "blacklisted_emails", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_blacklisted_emails_on_email", unique: true
  end

  create_table "dolphins", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "from_id", null: false
    t.string "source", null: false
    t.integer "to_id", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_dolphins_on_created_at"
    t.index ["from_id"], name: "index_dolphins_on_from_id"
    t.index ["to_id"], name: "index_dolphins_on_to_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.integer "from_count", default: 0, null: false
    t.string "image_url", null: false
    t.string "name", null: false
    t.string "nickname"
    t.string "provider", null: false
    t.integer "to_count", default: 0, null: false
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["from_count"], name: "index_users_on_from_count"
    t.index ["nickname"], name: "index_users_on_nickname", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["to_count"], name: "index_users_on_to_count"
  end

  add_foreign_key "dolphins", "users", column: "from_id"
  add_foreign_key "dolphins", "users", column: "to_id"
end
