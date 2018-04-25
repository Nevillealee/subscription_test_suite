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

ActiveRecord::Schema.define(version: 2018_04_25_221822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.boolean "accepts_marketing"
    t.jsonb "addresses"
    t.datetime "created_at"
    t.jsonb "default_address"
    t.string "email"
    t.string "first_name"
    t.string "customer_id"
    t.string "last_name"
    t.string "last_order_id"
    t.string "last_order_name"
    t.jsonb "metafield"
    t.string "multipass_identifier"
    t.string "note"
    t.integer "orders_count"
    t.string "phone"
    t.string "state"
    t.string "tags"
    t.boolean "tax_exempt"
    t.string "total_spent"
    t.datetime "updated_at"
    t.boolean "verified_email"
  end

  create_table "recharge_subs_config", force: :cascade do |t|
    t.string "product_id"
    t.string "variant_id"
    t.string "sku"
    t.string "product_title"
    t.string "collection_property"
  end

end
