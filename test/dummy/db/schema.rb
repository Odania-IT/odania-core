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

ActiveRecord::Schema.define(version: 20150309005705) do

  create_table "odania_categories", force: :cascade do |t|
    t.integer  "site_id",     limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "language_id", limit: 4
    t.string   "title",       limit: 255
    t.integer  "count",       limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "parent_id",   limit: 4
  end

  add_index "odania_categories", ["language_id"], name: "fk_rails_b6f160f48c", using: :btree
  add_index "odania_categories", ["parent_id"], name: "fk_rails_f606c04274", using: :btree
  add_index "odania_categories", ["site_id"], name: "fk_rails_f263166a14", using: :btree
  add_index "odania_categories", ["user_id"], name: "fk_rails_000a10b93b", using: :btree

  create_table "odania_category_xrefs", force: :cascade do |t|
    t.integer  "ref_id",      limit: 4
    t.string   "ref_type",    limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "odania_category_xrefs", ["category_id"], name: "index_odania_category_xrefs_on_category_id", using: :btree
  add_index "odania_category_xrefs", ["ref_type", "ref_id"], name: "index_odania_category_xrefs_on_ref_type_and_ref_id", using: :btree

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
    t.integer  "state",         limit: 4
  end

  add_index "odania_contents", ["language_id"], name: "fk_rails_fafd9872cb", using: :btree
  add_index "odania_contents", ["site_id", "language_id", "is_active"], name: "index_odania_contents_on_site_id_and_language_id_and_is_active", using: :btree
  add_index "odania_contents", ["user_id"], name: "index_odania_contents_on_user_id", using: :btree
  add_index "odania_contents", ["widget_id"], name: "fk_rails_308200440a", using: :btree

  create_table "odania_languages", force: :cascade do |t|
    t.string "name",       limit: 255
    t.string "iso_639_1",  limit: 255
    t.string "flag_image", limit: 255
  end

  add_index "odania_languages", ["iso_639_1"], name: "index_odania_languages_on_iso_639_1", unique: true, using: :btree

  create_table "odania_media", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.integer  "site_id",            limit: 4
    t.integer  "language_id",        limit: 4
    t.integer  "user_id",            limit: 4
    t.string   "copyright",          limit: 255
    t.boolean  "is_global",          limit: 1
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
  end

  add_index "odania_media", ["language_id"], name: "fk_rails_a4763b21cb", using: :btree
  add_index "odania_media", ["site_id", "language_id"], name: "index_odania_media_on_site_id_and_language_id", using: :btree
  add_index "odania_media", ["user_id"], name: "fk_rails_1747207b98", using: :btree

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
  add_index "odania_menu_items", ["parent_id"], name: "fk_rails_7ca9314b5f", using: :btree

  create_table "odania_menus", force: :cascade do |t|
    t.boolean  "published",            limit: 1
    t.integer  "default_menu_item_id", limit: 4
    t.integer  "site_id",              limit: 4
    t.integer  "language_id",          limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "widget_id",            limit: 4
  end

  add_index "odania_menus", ["default_menu_item_id"], name: "fk_rails_944fcf458c", using: :btree
  add_index "odania_menus", ["language_id"], name: "fk_rails_f25f1a0e45", using: :btree
  add_index "odania_menus", ["site_id", "language_id"], name: "index_odania_menus_on_site_id_and_language_id", unique: true, using: :btree

  create_table "odania_sites", force: :cascade do |t|
    t.string  "name",                    limit: 255
    t.string  "host",                    limit: 255
    t.boolean "is_active",               limit: 1
    t.boolean "is_default",              limit: 1
    t.text    "tracking_code",           limit: 65535
    t.text    "description",             limit: 65535
    t.string  "template",                limit: 255
    t.boolean "user_signup_allowed",     limit: 1,     default: false
    t.integer "default_language_id",     limit: 4
    t.integer "redirect_to_id",          limit: 4
    t.string  "default_from_email",      limit: 255
    t.string  "notify_email_address",    limit: 255
    t.integer "default_widget_id",       limit: 4
    t.text    "social",                  limit: 65535
    t.string  "domain",                  limit: 255
    t.string  "subdomain",               limit: 255
    t.integer "imprint_id",              limit: 4
    t.integer "terms_and_conditions_id", limit: 4
  end

  add_index "odania_sites", ["default_language_id"], name: "fk_rails_ddff4f74c3", using: :btree
  add_index "odania_sites", ["default_widget_id"], name: "fk_rails_c132bbfe82", using: :btree
  add_index "odania_sites", ["host"], name: "index_odania_sites_on_host", unique: true, using: :btree
  add_index "odania_sites", ["imprint_id"], name: "fk_rails_564bd8ddc0", using: :btree
  add_index "odania_sites", ["redirect_to_id"], name: "fk_rails_5ad3e58e8a", using: :btree
  add_index "odania_sites", ["terms_and_conditions_id"], name: "fk_rails_6d661c1717", using: :btree

  create_table "odania_static_pages", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "body",        limit: 65535
    t.integer  "clicks",      limit: 4
    t.integer  "views",       limit: 4
    t.integer  "site_id",     limit: 4
    t.integer  "language_id", limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "widget_id",   limit: 4
    t.boolean  "is_global",   limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "odania_static_pages", ["language_id"], name: "fk_rails_e4306875c8", using: :btree
  add_index "odania_static_pages", ["user_id"], name: "fk_rails_120dc2bb71", using: :btree
  add_index "odania_static_pages", ["widget_id"], name: "fk_rails_c22d263957", using: :btree

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

  add_index "odania_tags", ["language_id"], name: "fk_rails_6bf639a704", using: :btree
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

  add_index "odania_users", ["language_id"], name: "fk_rails_eca613f770", using: :btree
  add_index "odania_users", ["site_id"], name: "fk_rails_38559f4f0d", using: :btree

  create_table "odania_widgets", force: :cascade do |t|
    t.integer  "site_id",     limit: 4,                     null: false
    t.integer  "user_id",     limit: 4,                     null: false
    t.integer  "language_id", limit: 4,                     null: false
    t.string   "template",    limit: 255
    t.string   "name",        limit: 255
    t.text     "content",     limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "is_global",   limit: 1,     default: false
  end

  add_index "odania_widgets", ["language_id"], name: "index_odania_widgets_on_language_id", using: :btree
  add_index "odania_widgets", ["site_id"], name: "index_odania_widgets_on_site_id", using: :btree
  add_index "odania_widgets", ["user_id"], name: "index_odania_widgets_on_user_id", using: :btree

  add_foreign_key "odania_categories", "odania_categories", column: "parent_id"
  add_foreign_key "odania_categories", "odania_languages", column: "language_id"
  add_foreign_key "odania_categories", "odania_sites", column: "site_id"
  add_foreign_key "odania_categories", "odania_users", column: "user_id"
  add_foreign_key "odania_category_xrefs", "odania_categories", column: "category_id"
  add_foreign_key "odania_contents", "odania_languages", column: "language_id"
  add_foreign_key "odania_contents", "odania_sites", column: "site_id"
  add_foreign_key "odania_contents", "odania_users", column: "user_id"
  add_foreign_key "odania_contents", "odania_widgets", column: "widget_id"
  add_foreign_key "odania_media", "odania_languages", column: "language_id"
  add_foreign_key "odania_media", "odania_sites", column: "site_id"
  add_foreign_key "odania_media", "odania_users", column: "user_id"
  add_foreign_key "odania_menu_items", "odania_menu_items", column: "parent_id"
  add_foreign_key "odania_menu_items", "odania_menus", column: "menu_id"
  add_foreign_key "odania_menus", "odania_languages", column: "language_id"
  add_foreign_key "odania_menus", "odania_menu_items", column: "default_menu_item_id"
  add_foreign_key "odania_menus", "odania_sites", column: "site_id"
  add_foreign_key "odania_sites", "odania_languages", column: "default_language_id"
  add_foreign_key "odania_sites", "odania_sites", column: "redirect_to_id"
  add_foreign_key "odania_sites", "odania_static_pages", column: "imprint_id"
  add_foreign_key "odania_sites", "odania_static_pages", column: "terms_and_conditions_id"
  add_foreign_key "odania_sites", "odania_widgets", column: "default_widget_id"
  add_foreign_key "odania_static_pages", "odania_languages", column: "language_id"
  add_foreign_key "odania_static_pages", "odania_users", column: "user_id"
  add_foreign_key "odania_static_pages", "odania_widgets", column: "widget_id"
  add_foreign_key "odania_tag_xrefs", "odania_tags", column: "tag_id"
  add_foreign_key "odania_tags", "odania_languages", column: "language_id"
  add_foreign_key "odania_tags", "odania_sites", column: "site_id"
  add_foreign_key "odania_user_roles", "odania_users", column: "user_id"
  add_foreign_key "odania_users", "odania_languages", column: "language_id"
  add_foreign_key "odania_users", "odania_sites", column: "site_id"
  add_foreign_key "odania_widgets", "odania_languages", column: "language_id"
  add_foreign_key "odania_widgets", "odania_sites", column: "site_id"
  add_foreign_key "odania_widgets", "odania_users", column: "user_id"
end
