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

ActiveRecord::Schema[7.2].define(version: 2024_12_28_214746) do
  create_table "budgets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "month", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "month"], name: "index_budgets_on_user_id_and_month", unique: true
    t.index ["user_id"], name: "index_budgets_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.float "amount", null: false
    t.string "category", null: false
    t.text "description"
    t.datetime "date", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "budgets", "users"
  add_foreign_key "expenses", "users"
end
