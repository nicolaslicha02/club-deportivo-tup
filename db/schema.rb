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

ActiveRecord::Schema[8.1].define(version: 2026_10_07_134721) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.boolean "active"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.text "description"
    t.decimal "monthly_fee"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "club_settings", force: :cascade do |t|
    t.decimal "base_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enrollments", force: :cascade do |t|
    t.boolean "active"
    t.integer "activity_id", null: false
    t.datetime "created_at", null: false
    t.integer "member_profile_id", null: false
    t.date "start_date"
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_enrollments_on_activity_id"
    t.index ["member_profile_id"], name: "index_enrollments_on_member_profile_id"
  end

  create_table "member_profiles", force: :cascade do |t|
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.string "dni"
    t.string "first_name"
    t.string "last_name"
    t.string "member_number"
    t.string "phone"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_member_profiles_on_user_id"
  end

  create_table "membership_fees", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.date "due_date"
    t.integer "member_profile_id", null: false
    t.string "period"
    t.integer "status"
    t.datetime "updated_at", null: false
    t.index ["member_profile_id"], name: "index_membership_fees_on_member_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "api_token"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["api_token"], name: "index_users_on_api_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "enrollments", "activities"
  add_foreign_key "enrollments", "member_profiles"
  add_foreign_key "member_profiles", "users"
  add_foreign_key "membership_fees", "member_profiles"
end
