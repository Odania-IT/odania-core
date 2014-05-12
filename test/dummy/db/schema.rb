# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140425202800) do

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "odania_contents", force: true do |t|
    t.string   "title",                         null: false
    t.text     "body",                          null: false
    t.text     "body_filtered",                 null: false
    t.text     "body_short",                    null: false
    t.integer  "clicks",        default: 0
    t.integer  "views",         default: 0
    t.datetime "published_at",                  null: false
    t.boolean  "is_active",     default: false
    t.integer  "site_id",                       null: false
    t.integer  "language_id",                   null: false
    t.integer  "user_id",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "odania_contents", ["site_id", "language_id", "is_active"], name: "index_odania_contents_on_site_id_and_language_id_and_is_active", using: :btree
  add_index "odania_contents", ["user_id"], name: "index_odania_contents_on_user_id", using: :btree

  create_table "odania_languages", force: true do |t|
    t.string "name"
    t.string "iso_639_1"
  end

  add_index "odania_languages", ["iso_639_1"], name: "index_odania_languages_on_iso_639_1", unique: true, using: :btree

  create_table "odania_menu_items", force: true do |t|
    t.integer "menu_id"
    t.string  "title"
    t.boolean "published"
    t.string  "target_type"
    t.text    "target_data"
    t.integer "parent_id"
    t.integer "position"
    t.string  "full_path"
  end

  add_index "odania_menu_items", ["menu_id", "full_path"], name: "index_odania_menu_items_on_menu_id_and_full_path", using: :btree

  create_table "odania_menus", force: true do |t|
    t.string   "title"
    t.boolean  "published"
    t.integer  "default_menu_item_id"
    t.integer  "site_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "odania_menus", ["site_id", "language_id"], name: "index_odania_menus_on_site_id_and_language_id", unique: true, using: :btree

  create_table "odania_omniauth_identities", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "odania_omniauth_identities", ["email"], name: "omniauth_identities_email", using: :btree

  create_table "odania_omniauth_user_authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "odania_omniauth_user_authentications", ["provider", "uid"], name: "omniauth_authentications_provider_uid", using: :btree
  add_index "odania_omniauth_user_authentications", ["user_id", "provider"], name: "omniauth_authentications_user_id_provider", using: :btree

  create_table "odania_sites", force: true do |t|
    t.string  "name"
    t.string  "host"
    t.boolean "is_active"
    t.boolean "is_default"
    t.text    "tracking_code"
    t.text    "description"
    t.string  "template"
    t.boolean "user_signup_allowed", default: false
    t.integer "default_language_id"
    t.integer "redirect_to_id"
  end

  add_index "odania_sites", ["host"], name: "index_odania_sites_on_host", unique: true, using: :btree

  create_table "odania_tag_xrefs", force: true do |t|
    t.integer "tag_id"
    t.string  "ref_type"
    t.integer "ref_id"
    t.string  "context",  limit: 128
  end

  add_index "odania_tag_xrefs", ["ref_type", "ref_id", "context"], name: "index_odania_tag_xrefs_on_ref_type_and_ref_id_and_context", using: :btree
  add_index "odania_tag_xrefs", ["tag_id", "context"], name: "index_odania_tag_xrefs_on_tag_id_and_context", using: :btree

  create_table "odania_tags", force: true do |t|
    t.string  "name",                    null: false
    t.integer "site_id",                 null: false
    t.integer "count",       default: 0
    t.integer "language_id"
  end

  add_index "odania_tags", ["site_id", "name"], name: "index_odania_tags_on_site_id_and_name", unique: true, using: :btree

  create_table "odania_user_roles", force: true do |t|
    t.integer "user_id"
    t.integer "role",    default: 0
  end

  add_index "odania_user_roles", ["user_id"], name: "index_odania_user_roles_on_user_id", using: :btree

  create_table "odania_users", force: true do |t|
    t.string   "name"
    t.string   "email",        null: false
    t.string   "admin_layout"
    t.string   "ip"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id"
  end

end
