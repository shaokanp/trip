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

ActiveRecord::Schema.define(version: 20140220062327) do

  create_table "note_images", force: true do |t|
    t.string   "image"
    t.integer  "note_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "pin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pins", force: true do |t|
    t.string   "title"
    t.integer  "trip_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "pin_type"
    t.integer  "position"
    t.date     "end_time"
    t.integer  "day"
  end

  create_table "trips", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.datetime "start_date"
    t.integer  "days"
    t.string   "cover_image_url"
    t.boolean  "is_public"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "avatar_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
