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

ActiveRecord::Schema.define(version: 20140310135256) do

  create_table "merchants", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cid",        default: -1, null: false
  end

  add_index "merchants", ["cid"], name: "index_merchants_on_cid"

  create_table "offers", force: true do |t|
    t.integer  "merchant_id",              null: false
    t.string   "title",                    null: false
    t.string   "description"
    t.string   "url"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "link_id",     default: -1, null: false
  end

  add_index "offers", ["link_id"], name: "index_offers_on_link_id"

end
