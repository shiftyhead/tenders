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

ActiveRecord::Schema.define(version: 20161101230937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "region_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "tender_id"
    t.text     "content"
    t.text     "quantity"
    t.text     "price_one"
    t.text     "price_all"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tender_id"], name: "index_items_on_tender_id", using: :btree
  end

  create_table "tenders", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.float    "item_price"
    t.text     "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status"
    t.integer  "region"
    t.bigint   "item_count"
    t.bigint   "items_count"
    t.integer  "category"
    t.index ["company_id"], name: "index_tenders_on_company_id", using: :btree
  end

  add_foreign_key "items", "tenders"
end
