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

ActiveRecord::Schema.define(version: 2021_12_25_062729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ponds", force: :cascade do |t|
    t.string "key"
    t.string "uuid"
    t.string "postal_code"
    t.string "city"
    t.string "region"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ripples", force: :cascade do |t|
    t.string "uuid"
    t.string "postal_code"
    t.string "city"
    t.string "country"
    t.string "region"
    t.bigint "user_id"
    t.bigint "pond_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pond_id"], name: "index_ripples_on_pond_id"
    t.index ["user_id"], name: "index_ripples_on_user_id"
  end

  create_table "ripples_tags", force: :cascade do |t|
    t.bigint "ripple_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ripple_id"], name: "index_ripples_tags_on_ripple_id"
    t.index ["tag_id"], name: "index_ripples_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "organization"
    t.boolean "approved"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ripples", "ponds"
  add_foreign_key "ripples", "users"
  add_foreign_key "ripples_tags", "ripples"
  add_foreign_key "ripples_tags", "tags"
end
