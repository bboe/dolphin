# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150313141735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dolphins", force: :cascade do |t|
    t.string   "source",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "from_id",    null: false
    t.integer  "to_id",      null: false
  end

  add_index "dolphins", ["from_id"], name: "index_dolphins_on_from_id", using: :btree
  add_index "dolphins", ["to_id"], name: "index_dolphins_on_to_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "email",                  null: false
    t.string   "image_url",              null: false
    t.string   "provider",               null: false
    t.string   "uid",                    null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "from_count", default: 0, null: false
    t.integer  "to_count",   default: 0, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["from_count"], name: "index_users_on_from_count", using: :btree
  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["to_count"], name: "index_users_on_to_count", using: :btree

  add_foreign_key "dolphins", "users", column: "from_id"
  add_foreign_key "dolphins", "users", column: "to_id"
end
