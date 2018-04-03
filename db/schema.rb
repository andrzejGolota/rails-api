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

ActiveRecord::Schema.define(version: 20180329184813) do

  create_table "attachments", force: :cascade do |t|
    t.string "file", null: false
    t.integer "user_id"
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_attachments_on_invoice_id"
    t.index ["user_id"], name: "index_attachments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "company_number", null: false
    t.string "vat_number", null: false
    t.string "street", null: false
    t.string "postcode", null: false
    t.string "city", null: false
    t.string "region"
    t.string "country_code", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_number"], name: "index_companies_on_company_number"
    t.index ["country_code"], name: "index_companies_on_country_code"
    t.index ["user_id"], name: "index_companies_on_user_id"
    t.index ["vat_number"], name: "index_companies_on_vat_number"
  end

  create_table "contact_addresses", force: :cascade do |t|
    t.integer "contact_id"
    t.string "phone_number"
    t.string "email"
    t.string "street"
    t.string "postcode"
    t.string "city"
    t.boolean "default", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_addresses_on_contact_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "contact_user_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "company_id"
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_contacts_on_company_id"
    t.index ["contact_user_id"], name: "index_contacts_on_contact_user_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "costs", force: :cascade do |t|
    t.string "name"
    t.string "unit", null: false
    t.integer "quantity", null: false
    t.decimal "unit_price", null: false
    t.decimal "tax"
    t.string "cost_type"
    t.integer "user_id"
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_costs_on_invoice_id"
    t.index ["user_id"], name: "index_costs_on_user_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "country_name", null: false
    t.string "iso_code", null: false
    t.boolean "active", default: true, null: false
    t.index ["iso_code"], name: "index_countries_on_iso_code"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "user_id"
    t.integer "client_id"
    t.string "invoice_number"
    t.string "subject"
    t.integer "company_id"
    t.string "state", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["company_id"], name: "index_invoices_on_company_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "recipent_id"
    t.string "content"
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipent_id"], name: "index_messages_on_recipent_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "order_id"
    t.string "state", null: false
    t.decimal "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.decimal "price", null: false
    t.decimal "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email"
    t.string "login"
    t.string "password_digest"
    t.boolean "is_active", default: false, null: false
    t.datetime "activation_sent_date", null: false
    t.datetime "activated_at"
    t.string "activation_digest"
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_date"
    t.string "provider"
    t.string "avatar"
    t.boolean "contact_visibility", default: true, null: false
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["login"], name: "index_users_on_login"
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["uid"], name: "index_users_on_uid"
  end

end
