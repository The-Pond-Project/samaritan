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

ActiveRecord::Schema[7.0].define(version: 2022_08_13_081125) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bills", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "slug"
    t.integer "recurrence"
    t.integer "expense_type"
    t.float "amount", null: false
    t.boolean "paid", null: false
    t.datetime "due_at", precision: nil, null: false
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_bills_on_name"
    t.index ["slug"], name: "index_bills_on_slug"
  end

  create_table "flipper_features", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "message_subscriptions", force: :cascade do |t|
    t.string "phone_number", null: false
    t.string "ripple_uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_message_subscriptions_on_phone_number"
    t.index ["ripple_uuid"], name: "index_message_subscriptions_on_ripple_uuid"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "amount", null: false
    t.string "email"
    t.string "address1", null: false
    t.string "address2"
    t.string "city", null: false
    t.string "postal_code", null: false
    t.string "region", null: false
    t.string "country", null: false
    t.string "phone"
    t.string "uuid", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "shipped", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_orders_on_uuid"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.string "website"
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["deleted_at"], name: "index_organizations_on_deleted_at"
    t.index ["name"], name: "index_organizations_on_name", unique: true
    t.index ["slug"], name: "index_organizations_on_slug", unique: true
  end

  create_table "pond_batch_records", force: :cascade do |t|
    t.bigint "release_id", null: false
    t.integer "amount", null: false
    t.datetime "deleted_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["release_id"], name: "index_pond_batch_records_on_release_id"
  end

  create_table "ponds", force: :cascade do |t|
    t.string "key"
    t.string "uuid"
    t.string "postal_code"
    t.string "city"
    t.string "region"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.string "slug"
    t.integer "release_id"
    t.index ["deleted_at"], name: "index_ponds_on_deleted_at"
    t.index ["key"], name: "index_ponds_on_key", unique: true
    t.index ["slug"], name: "index_ponds_on_slug", unique: true
    t.index ["uuid"], name: "index_ponds_on_uuid", unique: true
  end

  create_table "releases", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.string "slug"
    t.index ["deleted_at"], name: "index_releases_on_deleted_at"
    t.index ["organization_id"], name: "index_releases_on_organization_id"
    t.index ["slug"], name: "index_releases_on_slug", unique: true
  end

  create_table "ripples", force: :cascade do |t|
    t.string "uuid"
    t.string "postal_code"
    t.string "city"
    t.string "country"
    t.string "region"
    t.bigint "user_id"
    t.bigint "pond_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.float "latitude"
    t.float "longitude"
    t.string "slug"
    t.boolean "vpn"
    t.boolean "precise_location", default: false
    t.string "county"
    t.index ["deleted_at"], name: "index_ripples_on_deleted_at"
    t.index ["pond_id"], name: "index_ripples_on_pond_id"
    t.index ["slug"], name: "index_ripples_on_slug", unique: true
    t.index ["user_id"], name: "index_ripples_on_user_id"
    t.index ["uuid"], name: "index_ripples_on_uuid", unique: true
  end

  create_table "ripples_tags", force: :cascade do |t|
    t.bigint "ripple_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ripple_id"], name: "index_ripples_tags_on_ripple_id"
    t.index ["tag_id"], name: "index_ripples_tags_on_tag_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "title"
    t.text "body", null: false
    t.string "pond_key"
    t.string "ripple_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.string "slug"
    t.integer "organization_id"
    t.index ["deleted_at"], name: "index_tags_on_deleted_at"
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at", precision: nil
    t.integer "role"
    t.string "invitation_token"
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at", precision: nil
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "releases", "organizations"
  add_foreign_key "ripples", "ponds"
  add_foreign_key "ripples", "users"
  add_foreign_key "ripples_tags", "ripples"
  add_foreign_key "ripples_tags", "tags"
end
