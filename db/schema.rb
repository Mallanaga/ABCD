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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131009093053) do

  create_table "categories", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string    "data_file_name",                  :null => false
    t.string    "data_content_type"
    t.integer   "data_file_size"
    t.integer   "assetable_id"
    t.string    "assetable_type",    :limit => 30
    t.string    "type",              :limit => 30
    t.integer   "width"
    t.integer   "height"
    t.timestamp "created_at",                      :null => false
    t.timestamp "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "designs", :force => true do |t|
    t.string    "name"
    t.text      "content"
    t.string    "url"
    t.string    "photo_url"
    t.date      "published_at"
    t.timestamp "created_at",   :null => false
    t.timestamp "updated_at",   :null => false
  end

  add_index "designs", ["name"], :name => "index_designs_on_name"
  add_index "designs", ["published_at"], :name => "index_designs_on_published_at"

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "summary"
    t.text     "content"
    t.string   "photo_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "entries", ["name"], :name => "index_entries_on_name"
  add_index "entries", ["updated_at"], :name => "index_entries_on_updated_at"

  create_table "tags", :force => true do |t|
    t.string    "taggable_type"
    t.integer   "taggable_id"
    t.integer   "category_id"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
  end

  add_index "tags", ["category_id"], :name => "index_tags_on_category_id"

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.string    "password_digest"
    t.string    "remember_token"
    t.timestamp "created_at",      :null => false
    t.timestamp "updated_at",      :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
