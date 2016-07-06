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

ActiveRecord::Schema.define(version: 20160706120715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bike_types", force: :cascade do |t|
    t.string   "name"
    t.text     "tagline"
    t.boolean  "available",  default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "bikes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "tagline"
    t.boolean  "available",    default: true
    t.integer  "bike_type_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "mobile"
    t.string   "email"
    t.string   "feedback_type"
    t.text     "comment"
    t.integer  "rating"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
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

  create_table "my_bikes", force: :cascade do |t|
    t.string   "bike"
    t.date     "purchase_date"
    t.string   "registration_number"
    t.string   "insurance_provider"
    t.string   "insurance_number"
    t.date     "insurance_expiry_date"
    t.string   "engine_number"
    t.date     "last_service_date"
    t.integer  "user_id"
    t.string   "bike_image"
    t.integer  "kms"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
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

  create_table "service_bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "my_bike_id"
    t.string   "registration_number"
    t.integer  "kms"
    t.date     "service_date"
    t.datetime "service_time"
    t.string   "service_station"
    t.text     "comments"
    t.string   "service_type"
    t.boolean  "request_pick_up",     default: false
    t.string   "service_status",      default: "Requested"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "specification_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "display_order"
    t.boolean  "active"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "specifications", force: :cascade do |t|
    t.string   "name"
    t.integer  "specification_type_id"
    t.integer  "bike_id"
    t.string   "value"
    t.boolean  "active"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "test_rides", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "mobile"
    t.string   "email"
    t.text     "address"
    t.boolean  "request_pick_up",     default: false
    t.boolean  "test_ride_done",      default: false
    t.boolean  "test_ride_confirmed", default: false
    t.string   "bike"
    t.date     "ride_date",                           null: false
    t.datetime "ride_time",                           null: false
    t.string   "location"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           default: "",      null: false
    t.string   "encrypted_password",              default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "authentication_token_created_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "role",                            default: "guest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
