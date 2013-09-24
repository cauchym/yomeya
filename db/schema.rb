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

ActiveRecord::Schema.define(version: 20130918051053) do

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "image"
    t.string   "author"
    t.string   "isbn"
    t.integer  "value"
    t.integer  "wishlist_id"
    t.text     "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shops", force: true do |t|
    t.string   "name"
    t.text     "book_id"
    t.float    "latitude"
    t.float    "longitude"
    t.time     "open_time"
    t.time     "close_time"
    t.string   "address"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.text     "wishlist_id"
    t.text     "ignore_shops"
    t.text     "ignore_books"
    t.float    "last_latitude"
    t.float    "last_longitude"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wishlists", force: true do |t|
    t.string   "url"
    t.string   "name"
    t.integer  "scrape_status"
    t.text     "book_id"
    t.text     "shop_id"
    t.boolean  "notice"
    t.integer  "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
