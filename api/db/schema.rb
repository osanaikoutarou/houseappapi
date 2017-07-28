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

ActiveRecord::Schema.define(version: 20170727111957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "architects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "icon_url"
    t.text     "name"
    t.text     "description"
    t.text     "policy"
    t.text     "affiliation"
    t.text     "qualifications"
    t.text     "speciality"
    t.text     "career"
    t.text     "homepage_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_architects_on_created_at", using: :btree
  end

  create_table "favorite_architects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "architect_id"
    t.uuid     "user_id"
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_houses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "house_id"
    t.uuid     "user_id"
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_photos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "photo_id"
    t.uuid     "user_id"
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "architect_id"
    t.text     "title"
    t.text     "description"
    t.text     "cost"
    t.text     "area"
    t.text     "space"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_houses_on_created_at", using: :btree
  end

  create_table "photos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "architect_id"
    t.uuid     "house_id"
    t.text     "title"
    t.string   "image_url"
    t.text     "description"
    t.string   "photo_type"
    t.integer  "priority"
    t.integer  "liked_count"
    t.integer  "passed_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "first_name_kana"
    t.text     "last_name_kana"
    t.string   "gender"
    t.string   "postal_code"
    t.string   "prefecture"
    t.text     "city"
    t.text     "address1"
    t.text     "address2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role",                   default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
