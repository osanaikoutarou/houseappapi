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

ActiveRecord::Schema.define(version: 20180511112453) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "admin_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
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
    t.index ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "admins", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
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
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "anonymous_users", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.json     "preferences"
    t.string   "device_name"
    t.string   "device_model"
    t.string   "device_idfv"
    t.string   "device_idfa"
    t.string   "device_gps_adid"
    t.string   "app_version"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_anonymous_users_on_user_id", using: :btree
  end

  create_table "architect_views", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "architect_id"
    t.uuid     "user_id"
    t.uuid     "anonymous_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["anonymous_user_id"], name: "index_architect_views_on_anonymous_user_id", using: :btree
    t.index ["architect_id"], name: "index_architect_views_on_architect_id", using: :btree
    t.index ["user_id"], name: "index_architect_views_on_user_id", using: :btree
  end

  create_table "architects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "affiliation"
    t.string   "zip_code"
    t.string   "prefecture"
    t.string   "city"
    t.string   "address1"
    t.string   "address2"
    t.decimal  "latitude",       precision: 10, scale: 6
    t.decimal  "longitude",      precision: 10, scale: 6
    t.text     "qualifications"
    t.text     "message"
    t.text     "introduction"
    t.string   "speciality"
    t.text     "career"
    t.string   "homepage"
    t.string   "avatar"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.uuid     "user_id"
    t.integer  "year_of_birth"
    t.integer  "gender"
    t.string   "hometown"
    t.index ["created_at"], name: "index_architects_on_created_at", using: :btree
    t.index ["user_id"], name: "index_architects_on_user_id", using: :btree
  end

  create_table "favorite_architects", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id",      null: false
    t.uuid     "architect_id", null: false
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_houses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id",    null: false
    t.uuid     "house_id",   null: false
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorite_photos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id",    null: false
    t.uuid     "photo_id",   null: false
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "house_articles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "house_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_house_articles_on_house_id", using: :btree
  end

  create_table "house_views", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "architect_id"
    t.uuid     "user_id"
    t.uuid     "anonymous_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["anonymous_user_id"], name: "index_house_views_on_anonymous_user_id", using: :btree
    t.index ["architect_id"], name: "index_house_views_on_architect_id", using: :btree
    t.index ["user_id"], name: "index_house_views_on_user_id", using: :btree
  end

  create_table "houses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "architect_id"
    t.string   "name"
    t.integer  "rank"
    t.integer  "floor_space"
    t.integer  "site_area_space"
    t.string   "area"
    t.string   "zip_code"
    t.string   "prefecture"
    t.string   "city"
    t.string   "address1"
    t.string   "address2"
    t.decimal  "latitude",        precision: 10, scale: 6
    t.decimal  "longitude",       precision: 10, scale: 6
    t.text     "description"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["created_at"], name: "index_houses_on_created_at", using: :btree
  end

  create_table "inquiries", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "architect_id",          null: false
    t.string   "approach_type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "first_name_kana"
    t.string   "last_name_kana"
    t.integer  "year_of_birth"
    t.string   "gender"
    t.string   "living_pref_name"
    t.string   "want_to_pref_name"
    t.string   "prefer_contact_method"
    t.string   "email"
    t.string   "phone_number"
    t.text     "message"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["architect_id"], name: "index_inquiries_on_architect_id", using: :btree
  end

  create_table "pg_search_documents", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.uuid     "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "photo_views", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "photo_id"
    t.uuid     "user_id"
    t.uuid     "anonymous_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["anonymous_user_id"], name: "index_photo_views_on_anonymous_user_id", using: :btree
    t.index ["photo_id"], name: "index_photo_views_on_photo_id", using: :btree
    t.index ["user_id"], name: "index_photo_views_on_user_id", using: :btree
  end

  create_table "photos", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "house_id"
    t.string   "image"
    t.string   "title"
    t.text     "description"
    t.boolean  "featured_photo", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "tag_id"
    t.string   "taggable_type"
    t.uuid     "taggable_id"
    t.string   "tagger_type"
    t.uuid     "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "user_profiles", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "first_name_kana"
    t.string   "last_name_kana"
    t.string   "gender"
    t.string   "zip_code"
    t.string   "prefecture"
    t.string   "city"
    t.string   "address1"
    t.string   "address2"
    t.decimal  "latitude",                  precision: 10, scale: 6
    t.decimal  "longitude",                 precision: 10, scale: 6
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.boolean  "displayed_tutorial"
    t.integer  "year_of_birth"
    t.string   "want_to_live_pref_name"
    t.boolean  "have_own_land"
    t.string   "user_states_for_architect"
    t.string   "price_policy"
    t.string   "resident_num"
    t.string   "child_num"
    t.string   "elderly_num"
    t.string   "pet_dog"
    t.string   "pet_cat"
    t.string   "pet_other"
    t.string   "nickname"
    t.string   "contents_of_request",                                default: [],              array: true
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
    t.uuid     "device_uuid"
    t.string   "facebook_id"
    t.string   "facebook_access_token"
    t.index ["device_uuid"], name: "index_users_on_device_uuid", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["facebook_id"], name: "index_users_on_facebook_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
