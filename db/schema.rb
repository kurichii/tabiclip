# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_05_09_142200) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "travel_book_id", null: false
    t.index ["travel_book_id"], name: "index_bookmarks_on_travel_book_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "check_lists", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "travel_book_id", null: false
    t.index ["travel_book_id"], name: "index_check_lists_on_travel_book_id"
    t.index ["uuid"], name: "index_check_lists_on_uuid", unique: true
  end

  create_table "list_items", force: :cascade do |t|
    t.string "title", null: false
    t.boolean "completed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "check_list_id", null: false
    t.index ["check_list_id"], name: "index_list_items_on_check_list_id"
  end

  create_table "notes", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "title", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "travel_book_id", null: false
    t.index ["travel_book_id"], name: "index_notes_on_travel_book_id"
    t.index ["uuid"], name: "index_notes_on_uuid", unique: true
  end

  create_table "reminders", force: :cascade do |t|
    t.datetime "reminder_date"
    t.boolean "completed", default: false, null: false
    t.bigint "list_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "job_id"
    t.index ["list_item_id"], name: "index_reminders_on_list_item_id"
  end

  create_table "schedule_icons", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "display_order"
  end

  create_table "schedules", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "title", null: false
    t.integer "budget", default: 0
    t.text "memo"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "schedule_icon_id"
    t.bigint "travel_book_id", null: false
    t.string "schedule_image"
    t.index ["travel_book_id"], name: "index_schedules_on_travel_book_id"
    t.index ["uuid"], name: "index_schedules_on_uuid", unique: true
  end

  create_table "spots", force: :cascade do |t|
    t.string "name"
    t.string "telephone"
    t.string "post_code"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.bigint "schedule_id", null: false
    t.index ["schedule_id"], name: "index_spots_on_schedule_id"
  end

  create_table "travel_books", force: :cascade do |t|
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.string "title", null: false
    t.text "description"
    t.boolean "is_public", default: false, null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "area_id"
    t.bigint "traveler_type_id"
    t.string "travel_book_image"
    t.bigint "creator_id", null: false
    t.string "invitation_token"
    t.index ["area_id"], name: "index_travel_books_on_area_id"
    t.index ["creator_id"], name: "index_travel_books_on_creator_id"
    t.index ["invitation_token"], name: "index_travel_books_on_invitation_token", unique: true
    t.index ["traveler_type_id"], name: "index_travel_books_on_traveler_type_id"
    t.index ["uuid"], name: "index_travel_books_on_uuid", unique: true
  end

  create_table "traveler_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_travel_books", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "travel_book_id", null: false
    t.index ["travel_book_id"], name: "index_user_travel_books_on_travel_book_id"
    t.index ["user_id"], name: "index_user_travel_books_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "icon_image"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "invited_by_travel_book_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "bookmarks", "travel_books"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "check_lists", "travel_books"
  add_foreign_key "list_items", "check_lists"
  add_foreign_key "notes", "travel_books"
  add_foreign_key "reminders", "list_items"
  add_foreign_key "schedules", "travel_books"
  add_foreign_key "spots", "schedules"
  add_foreign_key "travel_books", "areas"
  add_foreign_key "travel_books", "traveler_types"
  add_foreign_key "travel_books", "users", column: "creator_id"
  add_foreign_key "user_travel_books", "travel_books"
  add_foreign_key "user_travel_books", "users"
end
