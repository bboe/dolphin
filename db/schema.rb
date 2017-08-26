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

ActiveRecord::Schema.define(version: 20150317193151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dolphins", id: :serial, force: :cascade do |t|
    t.string "source", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "from_id", default: 1, null: false
    t.integer "to_id", default: 1, null: false
    t.index ["created_at"], name: "index_dolphins_on_created_at"
    t.index ["from_id"], name: "index_dolphins_on_from_id"
    t.index ["to_id"], name: "index_dolphins_on_to_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "image_url", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "from_count", default: 0, null: false
    t.integer "to_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["from_count"], name: "index_users_on_from_count"
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["to_count"], name: "index_users_on_to_count"
  end

  add_foreign_key "dolphins", "users", column: "from_id"
  add_foreign_key "dolphins", "users", column: "to_id"
end
