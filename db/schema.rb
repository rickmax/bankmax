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

ActiveRecord::Schema.define(version: 2020_07_25_001633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "balances", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "deposit_id"
    t.bigint "withdraw_id"
    t.bigint "transfer_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_balances_on_account_id"
    t.index ["deposit_id"], name: "index_balances_on_deposit_id"
    t.index ["transfer_id"], name: "index_balances_on_transfer_id"
    t.index ["withdraw_id"], name: "index_balances_on_withdraw_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.index ["city_id"], name: "index_banks_on_city_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "capital"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "deposits", force: :cascade do |t|
    t.bigint "account_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_deposits_on_account_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_states_on_region_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "account_id"
    t.decimal "amount"
    t.integer "account_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transfers_on_account_id"
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

  create_table "withdraws", force: :cascade do |t|
    t.bigint "account_id"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_withdraws_on_account_id"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "balances", "accounts"
  add_foreign_key "balances", "deposits"
  add_foreign_key "balances", "transfers"
  add_foreign_key "balances", "withdraws"
  add_foreign_key "banks", "cities"
  add_foreign_key "cities", "states"
  add_foreign_key "deposits", "accounts"
  add_foreign_key "states", "regions"
  add_foreign_key "transfers", "accounts"
  add_foreign_key "withdraws", "accounts"
end
