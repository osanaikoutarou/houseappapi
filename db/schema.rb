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

ActiveRecord::Schema.define(version: 20151228082047) do

  create_table "architects", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "liked_count"
    t.text     "icon_url"
    t.text     "title"
    t.text     "description"
    t.string   "house_uuid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "favorite_architects", force: :cascade do |t|
    t.string   "user_uuid"
    t.string   "house_uuid"
    t.boolean  "like"
    t.boolean  "dislike"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_houses", force: :cascade do |t|
    t.string   "user_uuid"
    t.string   "house_uuid"
    t.boolean  "like"
    t.boolean  "dislike"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_photos", force: :cascade do |t|
    t.string   "user_uuid"
    t.string   "photo_uuid"
    t.boolean  "like"
    t.boolean  "pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "view_count"
    t.integer  "liked_count"
    t.text     "title"
    t.text     "description"
    t.string   "photo_uuid"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string   "uuid"
    t.text     "title"
    t.string   "image_url"
    t.boolean  "like"
    t.boolean  "pass"
    t.integer  "liked_count"
    t.integer  "passed_count"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "uuid"
    t.text     "name_sei"
    t.text     "name_mei"
    t.text     "name_sei_kana"
    t.text     "name_mei_kana"
    t.string   "gender"
    t.string   "postal_code"
    t.string   "prefecture"
    t.text     "city"
    t.text     "address1"
    t.text     "address2"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
