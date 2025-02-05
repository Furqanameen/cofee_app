# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_04_223118) do
  create_table "combo_discounts", force: :cascade do |t|
    t.integer "discount_id"
    t.integer "item_id"
    t.integer "free_items_count", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id"], name: "index_combo_discounts_on_discount_id"
    t.index ["item_id"], name: "index_combo_discounts_on_item_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "discount_type", default: 0, null: false
    t.decimal "value", precision: 5, scale: 2
    t.text "condition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.integer "quantity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "item_id", null: false
    t.integer "quantity"
    t.decimal "unit_price"
    t.decimal "tax_rate"
    t.decimal "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "shop_id"
    t.integer "status", default: 0, null: false
    t.decimal "subtotal", precision: 10, scale: 2
    t.decimal "total", precision: 10, scale: 2
    t.decimal "tax_total", precision: 10, scale: 2
    t.decimal "discount_total", precision: 10, scale: 2
    t.datetime "paid_at"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["shop_id"], name: "index_orders_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "region"
    t.decimal "tax_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "combo_discounts", "discounts"
  add_foreign_key "combo_discounts", "items"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "shops"
end
