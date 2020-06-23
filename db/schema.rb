# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_22_221118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "annotations", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "user_id", null: false
    t.bigint "manifesto_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_annotations_on_category_id"
    t.index ["manifesto_item_id"], name: "index_annotations_on_manifesto_item_id"
    t.index ["user_id"], name: "index_annotations_on_user_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.string "district"
    t.string "photo"
    t.boolean "is_lead_candidate"
    t.string "candidate_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "position"
    t.bigint "party_id"
    t.text "biography"
    t.string "biography_source"
    t.string "link_parlamento"
    t.string "photo_source"
    t.index ["party_id"], name: "index_candidates_on_party_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "manifesto_item_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.boolean "hidden"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manifesto_item_id"], name: "index_comments_on_manifesto_item_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "manifesto_items", force: :cascade do |t|
    t.bigint "manifesto_section_id", null: false
    t.string "kind"
    t.integer "position"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "item_type"
    t.bigint "manifesto_item_id"
    t.string "digest"
    t.integer "version"
    t.integer "comments_count"
    t.bigint "annotation_id"
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
    t.index ["annotation_id"], name: "index_manifesto_items_on_annotation_id"
    t.index ["manifesto_item_id"], name: "index_manifesto_items_on_manifesto_item_id"
    t.index ["manifesto_section_id"], name: "index_manifesto_items_on_manifesto_section_id"
  end

  create_table "manifesto_sections", force: :cascade do |t|
    t.bigint "manifesto_id", null: false
    t.bigint "manifesto_section_id"
    t.integer "position"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "version", default: 1
    t.text "document_source"
    t.index ["manifesto_id"], name: "index_manifesto_sections_on_manifesto_id"
    t.index ["manifesto_section_id"], name: "index_manifesto_sections_on_manifesto_section_id"
  end

  create_table "manifestos", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "party_id"
    t.index ["party_id"], name: "index_manifestos_on_party_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "acronym"
    t.string "logo"
    t.string "name"
    t.string "website"
    t.string "email"
    t.text "description"
    t.string "description_source"
    t.date "description_updated_at"
    t.string "facebook"
    t.string "twitter"
    t.string "instagram"
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
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "annotations", "categories"
  add_foreign_key "annotations", "manifesto_items"
  add_foreign_key "annotations", "users"
  add_foreign_key "comments", "manifesto_items"
  add_foreign_key "comments", "users"
  add_foreign_key "manifesto_items", "annotations"
  add_foreign_key "manifesto_items", "manifesto_items"
  add_foreign_key "manifesto_items", "manifesto_sections"
  add_foreign_key "manifesto_sections", "manifesto_sections"
  add_foreign_key "manifesto_sections", "manifestos"
  add_foreign_key "manifestos", "parties"
end
