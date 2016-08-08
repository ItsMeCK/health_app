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

ActiveRecord::Schema.define(version: 20160805110657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "tag"
    t.string   "image"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "accessory_category_id"
    t.string   "part_number"
    t.string   "size"
    t.string   "price"
  end

  create_table "accessory_categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "accessory_enquiries", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "accessory_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "accessory_wishlists", force: :cascade do |t|
    t.integer  "accessory_id"
    t.integer  "wishlist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "banners", force: :cascade do |t|
    t.string   "image"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "bike_colors", force: :cascade do |t|
    t.string   "label"
    t.string   "color"
    t.integer  "bike_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.boolean  "available",            default: true
    t.integer  "bike_type_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "display_order"
    t.string   "service_schedule_url"
  end

  create_table "booking_time_controls", force: :cascade do |t|
    t.time     "open_time"
    t.time     "end_time"
    t.integer  "days_prior"
    t.string   "weekday"
    t.string   "category"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_numbers", force: :cascade do |t|
    t.string   "category"
    t.string   "number"
    t.string   "label"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "contact_type_id"
  end

  create_table "contact_types", force: :cascade do |t|
    t.string   "label"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "contact_type"
  end

  create_table "dealer_contact_labels", force: :cascade do |t|
    t.string   "label_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealer_contact_numbers", force: :cascade do |t|
    t.string   "number"
    t.integer  "dealer_id"
    t.integer  "dealer_contact_label_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "dealer_dealer_types", force: :cascade do |t|
    t.integer  "dealer_id"
    t.integer  "dealer_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "dealer_types", force: :cascade do |t|
    t.string   "dealer_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "dealer_types_dealers", force: :cascade do |t|
    t.integer  "dealer_id"
    t.integer  "dealer_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "dealers", force: :cascade do |t|
    t.string   "dealer_name"
    t.string   "address"
    t.string   "working_hours"
    t.string   "email"
    t.string   "latitude"
    t.string   "longitude"
    t.boolean  "active",                default: true
    t.string   "image"
    t.integer  "service_display_order"
    t.integer  "sales_display_order"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.text     "dealer_type_id"
  end

  create_table "default_bike_images", force: :cascade do |t|
    t.string   "image_url"
    t.integer  "bike_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "email_notification_templates", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.string   "category"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "enquiries", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "category"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.date     "event_date"
    t.time     "event_time"
    t.string   "location"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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

  create_table "finance_documents", force: :cascade do |t|
    t.string   "category"
    t.text     "document_list"
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

  create_table "insurance_renewals", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.string   "address"
    t.string   "bike"
    t.date     "purchase_date"
    t.integer  "kms"
    t.string   "registration_number"
    t.string   "insurance_company"
    t.string   "policy_number"
    t.string   "expiry_date"
    t.string   "status",              default: "Not Followed-Up"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "key_feature_types", force: :cascade do |t|
    t.string   "feature_type_name"
    t.boolean  "active",            default: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "key_features", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.integer  "bike_id"
    t.integer  "key_feature_type_id"
    t.boolean  "active",              default: true
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
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
    t.integer  "default_bike_image_id"
    t.string   "my_bike_image_url"
    t.integer  "bike_id"
  end

  create_table "my_docs", force: :cascade do |t|
    t.string   "image"
    t.string   "document_name"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "notification_categories", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notification_templates", force: :cascade do |t|
    t.text     "content"
    t.string   "title"
    t.string   "category"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "actor_id"
    t.datetime "read_at"
    t.string   "action"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "price_fields", force: :cascade do |t|
    t.string   "name"
    t.integer  "display_order"
    t.boolean  "active",        default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "pricings", force: :cascade do |t|
    t.integer  "price_field_id"
    t.string   "value"
    t.integer  "bike_id"
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
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

  create_table "rides", force: :cascade do |t|
    t.date     "ride_date"
    t.string   "route"
    t.string   "distance"
    t.string   "assembly_location"
    t.string   "destination_location"
    t.boolean  "notify"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "title"
    t.text     "assembly_time"
    t.text     "destination_time"
    t.text     "check_points"
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

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

  create_table "service_histories", force: :cascade do |t|
    t.date     "service_date"
    t.string   "service_type"
    t.integer  "kms"
    t.string   "total_cost"
    t.string   "bill_image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "my_bike_id"
  end

  create_table "service_numbers", force: :cascade do |t|
    t.string   "contact_name"
    t.string   "contact_number"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "service_schedules", force: :cascade do |t|
    t.string   "service_number"
    t.integer  "bike_id"
    t.string   "months"
    t.integer  "total_kms"
    t.string   "service_type"
    t.integer  "range"
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "set_booking_numbers", force: :cascade do |t|
    t.string   "booking_number"
    t.string   "category"
    t.string   "label"
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "set_mails", force: :cascade do |t|
    t.string   "email"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "set_rules", force: :cascade do |t|
    t.text     "days"
    t.string   "category"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
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

  create_table "tenures", force: :cascade do |t|
    t.string   "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   ""
    t.date     "ride_date",                           null: false
    t.datetime "ride_time",                           null: false
    t.string   "location"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "perticipate_event"
    t.date     "user_event_date"
  end

  create_table "user_rides", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "ride_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "perticipate_ride"
    t.date     "user_ride_date"
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
    t.string   "ios_token"
    t.string   "android_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wishlists", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
