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

ActiveRecord::Schema.define(version: 20170717201413) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "rus_name",   null: false
    t.string   "eng_name",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "site",        null: false
    t.string   "full_url"
    t.string   "source"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.integer  "city_id"
    t.index ["category_id"], name: "index_companies_on_category_id", using: :btree
    t.index ["city_id"], name: "index_companies_on_city_id", using: :btree
  end

  create_table "emails", force: :cascade do |t|
    t.string   "value",                      null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "company_id"
    t.boolean  "sended",     default: false
    t.index ["company_id"], name: "index_emails_on_company_id", using: :btree
    t.index ["value"], name: "index_emails_on_value", using: :btree
  end

  create_table "phones", force: :cascade do |t|
    t.string   "value",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.index ["company_id"], name: "index_phones_on_company_id", using: :btree
    t.index ["value"], name: "index_phones_on_value", using: :btree
  end

  add_foreign_key "companies", "categories"
  add_foreign_key "companies", "cities"
  add_foreign_key "emails", "companies"
  add_foreign_key "phones", "companies"
end
