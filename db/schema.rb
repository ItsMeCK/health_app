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

ActiveRecord::Schema.define(version: 20160618153002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bike_types", force: :cascade do |t|
    t.string   "name"
    t.text     "tagline"
    t.boolean  "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bikes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "tagline"
    t.boolean  "available"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "hog_registrations", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "mobile"
    t.date     "dob"
    t.string   "gender"
    t.string   "bike_owned"
    t.string   "riding_since"
    t.string   "address"
    t.string   "location"
    t.string   "profession"
    t.text     "bio"
    t.boolean  "hog_privacy"
    t.string   "profile_image"
    t.integer  "user_id"
    t.boolean  "show_hog",      default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "key_features", force: :cascade do |t|
    t.integer  "bike_id"
    t.jsonb    "features"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "full_name"
    t.string   "mobile"
    t.string   "email"
    t.date     "dob"
    t.string   "gender"
    t.string   "bike_owned"
    t.string   "riding_since"
    t.string   "address"
    t.string   "location"
    t.string   "profession"
    t.text     "bio"
    t.boolean  "hog_privacy",   default: false
    t.string   "profile_image"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "specifications", force: :cascade do |t|
    t.integer  "bike_id"
    t.jsonb    "pricing",    default: {}, null: false
    t.jsonb    "dimensions", default: {}, null: false
    t.jsonb    "engine",     default: {}, null: false
    t.jsonb    "drivetrain", default: {}, null: false
    t.jsonb    "chassis",    default: {}, null: false
    t.jsonb    "peformance", default: {}, null: false
    t.jsonb    "electric",   default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "specifications", ["chassis"], name: "index_specifications_on_chassis", using: :gin
  add_index "specifications", ["dimensions"], name: "index_specifications_on_dimensions", using: :gin
  add_index "specifications", ["drivetrain"], name: "index_specifications_on_drivetrain", using: :gin
  add_index "specifications", ["electric"], name: "index_specifications_on_electric", using: :gin
  add_index "specifications", ["engine"], name: "index_specifications_on_engine", using: :gin
  add_index "specifications", ["peformance"], name: "index_specifications_on_peformance", using: :gin
  add_index "specifications", ["pricing"], name: "index_specifications_on_pricing", using: :gin

  create_table "users", force: :cascade do |t|
    t.string   "email",                           default: "", null: false
    t.string   "encrypted_password",              default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "authentication_token_created_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
