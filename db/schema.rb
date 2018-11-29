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

ActiveRecord::Schema.define(version: 2018_11_29_062616) do

  create_table "posts", force: :cascade do |t|
    t.text "message"
    t.integer "src_id"
    t.integer "dst_id"
    t.boolean "read_flag", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "anc_id"
  end

  create_table "receives", force: :cascade do |t|
    t.integer "u_id"
    t.integer "mes_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "reply_flag", default: false, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "nickname"
    t.string "name"
    t.string "image_url"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
