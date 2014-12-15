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

ActiveRecord::Schema.define(version: 20141215083851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: true do |t|
    t.string   "category"
    t.integer  "number"
    t.string   "title"
    t.string   "condition"
    t.text     "description"
    t.integer  "start_price"
    t.integer  "current_bid"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "buy_now_price"
    t.integer  "reserve"
    t.string   "primary_picture"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "duration"
  end

  create_table "bids", force: true do |t|
    t.integer  "amount"
    t.datetime "bid_time"
    t.integer  "user_id"
    t.integer  "auction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_answers", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.boolean  "answered"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "auction_id"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
