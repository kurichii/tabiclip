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

ActiveRecord::Schema[7.2].define(version: 2025_01_11_012216) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "travel_books", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "is_public", default: false, null: false
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_travel_books", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "travel_book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["travel_book_id"], name: "index_user_travel_books_on_travel_book_id"
    t.index ["user_id", "travel_book_id"], name: "index_user_travel_books_on_user_id_and_travel_book_id", unique: true
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "user_travel_books", "travel_books"
  add_foreign_key "user_travel_books", "users"
end
