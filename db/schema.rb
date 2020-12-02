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

ActiveRecord::Schema.define(version: 2020_12_02_211413) do

  create_table "icecreamorders", force: :cascade do |t|
    t.integer "icecream_id"
    t.integer "order_id"
  end

  create_table "icecreams", force: :cascade do |t|
    t.string "flavor"
    t.integer "price"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "order_time"
    t.boolean "checked_out"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
  end

end
