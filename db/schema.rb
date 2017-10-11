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

ActiveRecord::Schema.define(version: 20171011024952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "company"
    t.string   "address_line_1", null: false
    t.string   "address_line_2"
    t.string   "address_line_3"
    t.string   "address_line_4"
    t.string   "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "client_id",  null: false
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["client_id"], name: "index_contacts_on_client_id", using: :btree

  create_table "conversion_rates", force: :cascade do |t|
    t.integer  "currency_id",                         null: false
    t.date     "valid_from",                          null: false
    t.date     "valid_to",                            null: false
    t.decimal  "rate",        precision: 6, scale: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversion_rates", ["currency_id"], name: "index_conversion_rates_on_currency_id", using: :btree

  create_table "currencies", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "code",       null: false
    t.string   "symbol",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: :cascade do |t|
    t.integer  "currency_id",                                  null: false
    t.decimal  "value",                precision: 8, scale: 2, null: false
    t.boolean  "includes_gst",                                 null: false
    t.string   "description",                                  null: false
    t.datetime "date",                                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recurring_expense_id"
  end

  add_index "expenses", ["currency_id"], name: "index_expenses_on_currency_id", using: :btree
  add_index "expenses", ["recurring_expense_id"], name: "index_expenses_on_recurring_expense_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "contact_id",                               null: false
    t.integer  "currency_id",                              null: false
    t.date     "date",                                     null: false
    t.boolean  "zero_rated_gst",                           null: false
    t.integer  "number",                                   null: false
    t.integer  "discount_in_percents",     default: 0,     null: false
    t.integer  "status",                   default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tax_rate_for_contractors", default: false, null: false
  end

  add_index "invoices", ["contact_id"], name: "index_invoices_on_contact_id", using: :btree
  add_index "invoices", ["currency_id"], name: "index_invoices_on_currency_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "invoice_id",                          null: false
    t.string   "description",                         null: false
    t.integer  "quantity",                            null: false
    t.decimal  "unit_price",  precision: 8, scale: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "line_items", ["invoice_id"], name: "index_line_items_on_invoice_id", using: :btree

  create_table "recurring_expenses", force: :cascade do |t|
    t.integer  "currency_id",                          null: false
    t.decimal  "value",        precision: 8, scale: 2, null: false
    t.boolean  "includes_gst",                         null: false
    t.string   "description",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recurring_expenses", ["currency_id"], name: "index_recurring_expenses_on_currency_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "schedulable_id"
    t.string   "schedulable_type"
    t.date     "date"
    t.time     "time"
    t.string   "rule"
    t.string   "interval"
    t.text     "day"
    t.text     "day_of_week"
    t.datetime "until"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "contacts", "clients"
  add_foreign_key "conversion_rates", "currencies"
  add_foreign_key "expenses", "currencies"
  add_foreign_key "expenses", "recurring_expenses"
  add_foreign_key "invoices", "contacts"
  add_foreign_key "invoices", "currencies"
  add_foreign_key "line_items", "invoices"
  add_foreign_key "recurring_expenses", "currencies"
end
