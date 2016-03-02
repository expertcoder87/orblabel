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

ActiveRecord::Schema.define(version: 20151027100351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "number"
    t.string   "district"
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "store_id"
  end

  add_index "addresses", ["store_id"], name: "index_addresses_on_store_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "bike_parts", force: :cascade do |t|
    t.integer  "bike_part_type"
    t.string   "brand"
    t.string   "model"
    t.date     "building_date"
    t.string   "serial_number"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "bike_id"
    t.integer  "maintenance_event_id"
  end

  add_index "bike_parts", ["bike_id"], name: "index_bike_parts_on_bike_id", using: :btree
  add_index "bike_parts", ["maintenance_event_id"], name: "index_bike_parts_on_maintenance_event_id", using: :btree

  create_table "bikes", force: :cascade do |t|
    t.string   "brand"
    t.string   "model"
    t.integer  "size"
    t.date     "building_date"
    t.string   "serial_number"
    t.string   "certification"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "store_id"
    t.string   "bike_image_file_name"
    t.string   "bike_image_content_type"
    t.integer  "bike_image_file_size"
    t.datetime "bike_image_updated_at"
    t.boolean  "robery_alert"
    t.boolean  "bike_registration_confirm"
  end

  add_index "bikes", ["store_id"], name: "index_bikes_on_store_id", using: :btree

  create_table "certified_bikes", force: :cascade do |t|
    t.string   "email"
    t.string   "email_confirmation"
    t.string   "selling_price"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "receipt_file_name"
    t.string   "receipt_content_type"
    t.integer  "receipt_file_size"
    t.datetime "receipt_updated_at"
    t.integer  "bike_id"
    t.string   "access_code"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.boolean  "communication_check"
  end

  create_table "maintenance_events", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "store_id"
    t.string   "maintenance_receipt_image_file_name"
    t.string   "maintenance_receipt_image_content_type"
    t.integer  "maintenance_receipt_image_file_size"
    t.datetime "maintenance_receipt_image_updated_at"
    t.text     "description"
    t.integer  "bike_id"
  end

  add_index "maintenance_events", ["store_id"], name: "index_maintenance_events_on_store_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "public_name"
    t.string   "legal_name"
    t.string   "cnpj"
    t.string   "area_code"
    t.string   "phone_number"
    t.string   "responsible_name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "confirmable"
    t.integer  "no_of_certificate"
    t.boolean  "status"
    t.string   "checkbox"
  end

  add_index "stores", ["email"], name: "index_stores_on_email", unique: true, using: :btree
  add_index "stores", ["reset_password_token"], name: "index_stores_on_reset_password_token", unique: true, using: :btree

  create_table "stores_roles", id: false, force: :cascade do |t|
    t.integer "store_id"
    t.integer "role_id"
  end

  add_index "stores_roles", ["store_id", "role_id"], name: "index_stores_roles_on_store_id_and_role_id", using: :btree

  create_table "uncertified_bikes", force: :cascade do |t|
    t.string   "name"
    t.string   "cpf"
    t.string   "email"
    t.string   "email_confirmation"
    t.string   "area_code"
    t.string   "cell_phone_number"
    t.string   "street"
    t.string   "number"
    t.string   "district"
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.string   "certification"
    t.string   "certification_confirm"
    t.string   "selling_price"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "receipt_file_name"
    t.string   "receipt_content_type"
    t.integer  "receipt_file_size"
    t.datetime "receipt_updated_at"
    t.integer  "bike_id"
    t.string   "access_code"
  end

end
