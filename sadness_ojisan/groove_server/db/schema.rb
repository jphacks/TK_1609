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

ActiveRecord::Schema.define(version: 20161029020002) do

  create_table "answers", force: :cascade do |t|
    t.text     "content"
    t.integer  "dancer_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["dancer_id"], name: "index_answers_on_dancer_id"
  add_index "answers", ["question_id"], name: "index_answers_on_question_id"

  create_table "api_keys", force: :cascade do |t|
    t.string   "access_token"
    t.datetime "expires_at"
    t.boolean  "active"
    t.integer  "dancer_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "api_keys", ["dancer_id"], name: "index_api_keys_on_dancer_id"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "record_id"
    t.integer  "dancer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["dancer_id"], name: "index_comments_on_dancer_id"
  add_index "comments", ["record_id"], name: "index_comments_on_record_id"

  create_table "dancers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "dancer_id"
    t.integer  "record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["dancer_id"], name: "index_favorites_on_dancer_id"
  add_index "favorites", ["record_id"], name: "index_favorites_on_record_id"

  create_table "follows", force: :cascade do |t|
    t.integer  "dancer_id"
    t.integer  "follow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "follows", ["dancer_id"], name: "index_follows_on_dancer_id"

  create_table "musics", force: :cascade do |t|
    t.string   "name"
    t.integer  "bpm"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "dancer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["dancer_id"], name: "index_questions_on_dancer_id"

  create_table "records", force: :cascade do |t|
    t.string   "title"
    t.text     "introduction"
    t.string   "effect"
    t.string   "movie"
    t.integer  "dancer_id"
    t.integer  "music_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "records", ["dancer_id"], name: "index_records_on_dancer_id"
  add_index "records", ["music_id"], name: "index_records_on_music_id"

end
