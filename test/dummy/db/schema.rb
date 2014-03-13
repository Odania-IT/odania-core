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

ActiveRecord::Schema.define(version: 20140313225265) do

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

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "contents", force: true do |t|
    t.string   "title",                        null: false
    t.text     "body",                         null: false
    t.text     "body_short",                   null: false
    t.integer  "clicks",       default: 0
    t.integer  "views",        default: 0
    t.datetime "published_at",                 null: false
    t.boolean  "is_active",    default: false
    t.integer  "site_id",                      null: false
    t.integer  "language_id",                  null: false
    t.integer  "user_id",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contents", ["site_id", "is_active"], name: "index_contents_on_site_id_and_is_active"
  add_index "contents", ["user_id"], name: "index_contents_on_user_id"

  create_table "languages", force: true do |t|
    t.string "name"
    t.string "iso_639_1"
  end

  add_index "languages", ["iso_639_1"], name: "index_languages_on_iso_639_1", unique: true

  create_table "menu_items", force: true do |t|
    t.integer "menu_id"
    t.string  "title"
    t.boolean "published"
    t.string  "target_type"
    t.text    "target_data"
    t.integer "parent_id"
  end

  add_index "menu_items", ["menu_id"], name: "index_menu_items_on_menu_id"

  create_table "menus", force: true do |t|
    t.string   "title"
    t.boolean  "published"
    t.integer  "default_menu_item"
    t.string   "prefix"
    t.integer  "site_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["site_id", "language_id"], name: "index_menus_on_site_id_and_language_id", unique: true

  create_table "sites", force: true do |t|
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

  add_index "sites", ["host"], name: "index_sites_on_host", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "admin_layout"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
