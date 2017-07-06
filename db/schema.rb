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

ActiveRecord::Schema.define(version: 20170706223642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string  "phone",   limit: 20,  null: false
    t.string  "email",   limit: 100, null: false
    t.integer "user_id"
    t.string  "name",    limit: 100
  end

  create_table "inventories", force: :cascade do |t|
    t.string  "name",        limit: 100,                         null: false
    t.decimal "price",                   precision: 8, scale: 2, null: false
    t.integer "stock",                                           null: false
    t.integer "weight"
    t.integer "calories"
    t.text    "description"
    t.string  "image",       limit: 255
  end

  create_table "inventory_ratings", force: :cascade do |t|
    t.integer "rating"
    t.integer "customer_id",  null: false
    t.integer "inventory_id", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.integer  "item_price_cents"
    t.integer  "total_price_cents"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "location", force: :cascade do |t|
    t.string "street",    limit: 150, null: false
    t.string "longitude", limit: 40,  null: false
    t.string "latitude",  limit: 40,  null: false
  end

  create_table "migrations", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "batch"
    t.datetime "migration_time"
  end

  create_table "migrations_lock", id: false, force: :cascade do |t|
    t.integer "is_locked"
  end

  create_table "order_feedbacks", force: :cascade do |t|
    t.text    "text",     null: false
    t.integer "order_id", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id",     null: false
    t.integer "inventory_id", null: false
    t.integer "qty"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "total_cents"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "stripe_charge_id"
    t.string   "email"
  end

  create_table "payments", force: :cascade do |t|
    t.string  "type",        limit: 10, null: false
    t.string  "card_no",     limit: 30
    t.string  "card_csc",    limit: 3
    t.date    "card_expiry"
    t.integer "order_id",               null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.integer  "price_cents"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string  "name",        limit: 100, null: false
    t.string  "phone",       limit: 20,  null: false
    t.integer "location_id",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "inventory_ratings", "customers", name: "inventory_ratings_customer_id_foreign"
  add_foreign_key "inventory_ratings", "inventories", name: "inventory_ratings_inventory_id_foreign"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "order_items", "inventories", name: "order_items_inventory_id_foreign"
  add_foreign_key "products", "categories"
  add_foreign_key "restaurants", "location", name: "restaurants_location_id_foreign"
end
