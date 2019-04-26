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

ActiveRecord::Schema.define(version: 2019_04_25_222100) do

  create_table "repositories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "language", limit: 1, null: false
    t.string "name", null: false
    t.string "full_name", null: false
    t.text "description", limit: 16777215
    t.text "url", limit: 16777215, null: false
    t.string "owner_login", null: false
    t.text "owner_avatar_url", limit: 16777215
    t.bigint "forks", null: false
    t.bigint "open_issues", null: false
    t.bigint "stargazers_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
