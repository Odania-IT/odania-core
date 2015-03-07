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

ActiveRecord::Schema.define(version: 20150307141348) do

  create_table "odania_click_trackings", force: :cascade do |t|
    t.integer  "obj_id"
    t.string   "obj_type"
    t.datetime "view_date"
    t.string   "referer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "odania_contents", force: :cascade do |t|
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
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "widget_id"
  end

  add_index "odania_contents", ["site_id", "language_id", "is_active"], name: "index_odania_contents_on_site_id_and_language_id_and_is_active"
  add_index "odania_contents", ["user_id"], name: "index_odania_contents_on_user_id"

  create_table "odania_languages", force: :cascade do |t|
    t.string "name"
    t.string "iso_639_1"
    t.string "flag_image"
  end

  add_index "odania_languages", ["iso_639_1"], name: "index_odania_languages_on_iso_639_1", unique: true

  create_table "odania_menu_items", force: :cascade do |t|
    t.integer "menu_id"
    t.string  "title"
    t.boolean "published"
    t.string  "target_type"
    t.text    "target_data"
    t.integer "parent_id"
    t.integer "position"
    t.string  "full_path"
  end

  add_index "odania_menu_items", ["menu_id", "full_path"], name: "index_odania_menu_items_on_menu_id_and_full_path"

  create_table "odania_menus", force: :cascade do |t|
    t.boolean  "published"
    t.integer  "default_menu_item_id"
    t.integer  "site_id"
    t.integer  "language_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "widget_id"
  end

  add_index "odania_menus", ["site_id", "language_id"], name: "index_odania_menus_on_site_id_and_language_id", unique: true

  create_table "odania_sites", force: :cascade do |t|
    t.string  "name"
    t.string  "host"
    t.boolean "is_active"
    t.boolean "is_default"
    t.text    "tracking_code"
    t.text    "description"
    t.string  "template"
    t.boolean "user_signup_allowed",  default: false
    t.integer "default_language_id"
    t.integer "redirect_to_id"
    t.string  "default_from_email"
    t.string  "notify_email_address"
    t.text    "imprint"
    t.text    "terms_and_conditions"
    t.integer "default_widget_id"
    t.text    "social"
  end

  add_index "odania_sites", ["host"], name: "index_odania_sites_on_host", unique: true

  create_table "odania_tag_xrefs", force: :cascade do |t|
    t.integer "tag_id"
    t.string  "ref_type"
    t.integer "ref_id"
    t.string  "context",  limit: 128
  end

  add_index "odania_tag_xrefs", ["ref_type", "ref_id", "context"], name: "index_odania_tag_xrefs_on_ref_type_and_ref_id_and_context"
  add_index "odania_tag_xrefs", ["tag_id", "context"], name: "index_odania_tag_xrefs_on_tag_id_and_context"

  create_table "odania_tags", force: :cascade do |t|
    t.string  "name",                    null: false
    t.integer "site_id",                 null: false
    t.integer "count",       default: 0
    t.integer "language_id"
  end

  add_index "odania_tags", ["site_id", "language_id", "name"], name: "index_odania_tags_on_site_id_and_language_id_and_name", unique: true

  create_table "odania_user_roles", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role",    default: 0
  end

  add_index "odania_user_roles", ["user_id"], name: "index_odania_user_roles_on_user_id"

  create_table "odania_users", force: :cascade do |t|
    t.integer  "site_id"
    t.string   "name"
    t.string   "email"
    t.string   "admin_layout"
    t.string   "ip"
    t.datetime "last_login"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "language_id"
  end

  create_table "odania_widgets", force: :cascade do |t|
    t.integer  "site_id",                     null: false
    t.integer  "user_id",                     null: false
    t.integer  "language_id",                 null: false
    t.string   "template"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_global",   default: false
  end

  add_index "odania_widgets", ["language_id"], name: "index_odania_widgets_on_language_id"
  add_index "odania_widgets", ["site_id"], name: "index_odania_widgets_on_site_id"
  add_index "odania_widgets", ["user_id"], name: "index_odania_widgets_on_user_id"

end
