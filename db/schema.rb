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

ActiveRecord::Schema.define(version: 20130624205234) do

  create_table "sections", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["id"], name: "index_sections_on_id"

  create_table "users", force: true do |t|
    t.string   "github_uid"
    t.string   "name"
    t.integer  "section_id"
    t.string   "job_type"
    t.string   "irc_name"
    t.string   "nickname"
    t.string   "birthday"
    t.text     "birthplace"
    t.text     "background"
    t.text     "ppb_carrier"
    t.text     "hometown"
    t.text     "hobby"
    t.text     "favorite_food"
    t.text     "favorite_book"
    t.text     "club"
    t.text     "strong_point"
    t.text     "free_space"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["github_uid"], name: "index_users_on_github_uid"
  add_index "users", ["id"], name: "index_users_on_id"
  add_index "users", ["irc_name"], name: "index_users_on_irc_name"
  add_index "users", ["nickname"], name: "index_users_on_nickname"
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
