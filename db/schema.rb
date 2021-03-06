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

ActiveRecord::Schema.define(version: 2019_02_15_005335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invites", force: :cascade do |t|
    t.string "user_email"
    t.bigint "playlist_cleaner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_cleaner_id"], name: "index_invites_on_playlist_cleaner_id"
  end

  create_table "playlist_cleaner_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "playlist_cleaner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_cleaner_id"], name: "index_playlist_cleaner_users_on_playlist_cleaner_id"
    t.index ["user_id"], name: "index_playlist_cleaner_users_on_user_id"
  end

  create_table "playlist_cleaners", force: :cascade do |t|
    t.bigint "creator_id"
    t.string "spotify_playlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "playlist_name"
    t.string "playlist_picture_url"
    t.index ["creator_id"], name: "index_playlist_cleaners_on_creator_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "playlist_cleaner_id"
    t.string "spotify_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "saved_to_library", default: false
    t.index ["playlist_cleaner_id"], name: "index_tracks_on_playlist_cleaner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "spotify_picture_url"
    t.string "display_name"
    t.string "token"
    t.datetime "token_expiry"
    t.jsonb "spotify_user_hash"
    t.string "spotify_id"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "track_id"
    t.string "spotify_playlist_id"
    t.string "spotify_playlist_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.index ["track_id"], name: "index_votes_on_track_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "invites", "playlist_cleaners"
  add_foreign_key "playlist_cleaner_users", "playlist_cleaners"
  add_foreign_key "playlist_cleaner_users", "users"
  add_foreign_key "tracks", "playlist_cleaners"
  add_foreign_key "votes", "tracks"
  add_foreign_key "votes", "users"
end
