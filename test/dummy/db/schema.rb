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

ActiveRecord::Schema.define(version: 20150306152017) do

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "odania_click_trackings", force: :cascade do |t|
    t.integer  "obj_id",     limit: 4
    t.string   "obj_type",   limit: 255
    t.datetime "view_date"
    t.string   "referer",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "odania_contents", force: :cascade do |t|
    t.string   "title",         limit: 255,                   null: false
    t.text     "body",          limit: 65535,                 null: false
    t.text     "body_filtered", limit: 65535,                 null: false
    t.text     "body_short",    limit: 65535,                 null: false
    t.integer  "clicks",        limit: 4,     default: 0
    t.integer  "views",         limit: 4,     default: 0
    t.datetime "published_at",                                null: false
    t.boolean  "is_active",     limit: 1,     default: false
    t.integer  "site_id",       limit: 4,                     null: false
    t.integer  "language_id",   limit: 4,                     null: false
    t.integer  "user_id",       limit: 4,                     null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "widget_id",     limit: 4
  end

  add_index "odania_contents", ["site_id", "language_id", "is_active"], name: "index_odania_contents_on_site_id_and_language_id_and_is_active", using: :btree
  add_index "odania_contents", ["user_id"], name: "index_odania_contents_on_user_id", using: :btree

  create_table "odania_languages", force: :cascade do |t|
    t.string "name",       limit: 255
    t.string "iso_639_1",  limit: 255
    t.string "flag_image", limit: 255
  end

  add_index "odania_languages", ["iso_639_1"], name: "index_odania_languages_on_iso_639_1", unique: true, using: :btree

  create_table "odania_menu_items", force: :cascade do |t|
    t.integer "menu_id",     limit: 4
    t.string  "title",       limit: 255
    t.boolean "published",   limit: 1
    t.string  "target_type", limit: 255
    t.text    "target_data", limit: 65535
    t.integer "parent_id",   limit: 4
    t.integer "position",    limit: 4
    t.string  "full_path",   limit: 255
  end

  add_index "odania_menu_items", ["menu_id", "full_path"], name: "index_odania_menu_items_on_menu_id_and_full_path", using: :btree

  create_table "odania_menus", force: :cascade do |t|
    t.boolean  "published",            limit: 1
    t.integer  "default_menu_item_id", limit: 4
    t.integer  "site_id",              limit: 4
    t.integer  "language_id",          limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "widget_id",            limit: 4
  end

  add_index "odania_menus", ["site_id", "language_id"], name: "index_odania_menus_on_site_id_and_language_id", unique: true, using: :btree

  create_table "odania_sites", force: :cascade do |t|
    t.string  "name",                 limit: 255
    t.string  "host",                 limit: 255
    t.boolean "is_active",            limit: 1
    t.boolean "is_default",           limit: 1
    t.text    "tracking_code",        limit: 65535
    t.text    "description",          limit: 65535
    t.string  "template",             limit: 255
    t.boolean "user_signup_allowed",  limit: 1,     default: false
    t.integer "default_language_id",  limit: 4
    t.integer "redirect_to_id",       limit: 4
    t.string  "default_from_email",   limit: 255
    t.string  "notify_email_address", limit: 255
    t.text    "imprint",              limit: 65535
    t.text    "terms_and_conditions", limit: 65535
    t.integer "default_widget_id",    limit: 4
  end

  add_index "odania_sites", ["host"], name: "index_odania_sites_on_host", unique: true, using: :btree

  create_table "odania_tag_xrefs", force: :cascade do |t|
    t.integer "tag_id",   limit: 4
    t.string  "ref_type", limit: 255
    t.integer "ref_id",   limit: 4
    t.string  "context",  limit: 128
  end

  add_index "odania_tag_xrefs", ["ref_type", "ref_id", "context"], name: "index_odania_tag_xrefs_on_ref_type_and_ref_id_and_context", using: :btree
  add_index "odania_tag_xrefs", ["tag_id", "context"], name: "index_odania_tag_xrefs_on_tag_id_and_context", using: :btree

  create_table "odania_tags", force: :cascade do |t|
    t.string  "name",        limit: 255,             null: false
    t.integer "site_id",     limit: 4,               null: false
    t.integer "count",       limit: 4,   default: 0
    t.integer "language_id", limit: 4
  end

  add_index "odania_tags", ["site_id", "language_id", "name"], name: "index_odania_tags_on_site_id_and_language_id_and_name", unique: true, using: :btree

  create_table "odania_user_roles", force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role",    limit: 4, default: 0
  end

  add_index "odania_user_roles", ["user_id"], name: "index_odania_user_roles_on_user_id", using: :btree

  create_table "odania_users", force: :cascade do |t|
    t.integer  "site_id",      limit: 4
    t.string   "name",         limit: 255
    t.string   "email",        limit: 255
    t.string   "admin_layout", limit: 255
    t.string   "ip",           limit: 255
    t.datetime "last_login"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "language_id",  limit: 4
  end

  create_table "odania_widgets", force: :cascade do |t|
    t.integer  "site_id",     limit: 4,     null: false
    t.integer  "user_id",     limit: 4,     null: false
    t.integer  "language_id", limit: 4,     null: false
    t.string   "template",    limit: 255
    t.string   "name",        limit: 255
    t.text     "content",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "odania_widgets", ["language_id"], name: "index_odania_widgets_on_language_id", using: :btree
  add_index "odania_widgets", ["site_id"], name: "index_odania_widgets_on_site_id", using: :btree
  add_index "odania_widgets", ["user_id"], name: "index_odania_widgets_on_user_id", using: :btree

end
