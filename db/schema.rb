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

ActiveRecord::Schema.define(:version => 20121006161150) do

  create_table "accounts", :force => true do |t|
    t.string    "email",                                  :null => false
    t.string    "crypted_password",                       :null => false
    t.string    "password_salt",                          :null => false
    t.string    "persistence_token",                      :null => false
    t.string    "single_access_token",                    :null => false
    t.string    "perishable_token",                       :null => false
    t.integer   "login_count",         :default => 0,     :null => false
    t.integer   "failed_login_count",  :default => 0,     :null => false
    t.timestamp "last_request_at"
    t.timestamp "current_login_at"
    t.timestamp "last_login_at"
    t.string    "current_login_ip"
    t.string    "last_login_ip"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.timestamp "joined_at"
    t.timestamp "expired_at"
    t.boolean   "active",              :default => false
    t.boolean   "activated",           :default => false
    t.timestamp "activated_at"
  end

  create_table "categories", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "email_addresses", :force => true do |t|
    t.string    "address"
    t.integer   "user_id"
    t.integer   "email_address_type_id"
    t.boolean   "primary",               :default => true
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "events", :force => true do |t|
    t.boolean   "active"
    t.string    "name"
    t.timestamp "start_at"
    t.timestamp "end_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "url_friendly"
    t.text      "description"
    t.boolean   "sponsored"
    t.integer   "max_attendance"
    t.string    "sponsor_file_name"
    t.string    "sponsor_content_type"
    t.integer   "sponsor_file_size"
    t.timestamp "sponsor_updated_at"
  end

  create_table "guests", :force => true do |t|
    t.string    "first_name"
    t.string    "last_name"
    t.string    "email"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer   "product_id",   :null => false
    t.string    "product_type", :null => false
    t.string    "name",         :null => false
    t.decimal   "price",        :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "items", ["product_id"], :name => "index_items_on_product_id"
  add_index "items", ["product_type"], :name => "index_items_on_product_type"

  create_table "locations", :force => true do |t|
    t.integer "participant_id"
    t.string  "address"
    t.string  "address_cont"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "phone"
    t.integer "region_id"
    t.string  "google_map_link"
  end

  add_index "locations", ["participant_id"], :name => "index_locations_on_participant_id"
  add_index "locations", ["region_id"], :name => "index_locations_on_region_id"

  create_table "memberships", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.integer   "order_id",   :null => false
    t.integer   "item_id",    :null => false
    t.integer   "quantity",   :null => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "order_items", ["item_id"], :name => "index_order_items_on_item_id"
  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"

  create_table "orders", :force => true do |t|
    t.integer   "customer_id",                         :null => false
    t.string    "customer_type",                       :null => false
    t.decimal   "amount",                              :null => false
    t.string    "express_token"
    t.string    "express_payer_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.boolean   "complete",         :default => false
  end

  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"
  add_index "orders", ["customer_type"], :name => "index_orders_on_customer_type"
  add_index "orders", ["express_payer_id"], :name => "index_orders_on_express_payer_id"

  create_table "participants", :force => true do |t|
    t.string    "name"
    t.string    "url"
    t.text      "bio"
    t.text      "benefit"
    t.text      "instructions"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "logo_file_name"
    t.string    "logo_content_type"
    t.integer   "logo_file_size"
    t.timestamp "logo_updated_at"
    t.integer   "category_id"
  end

  create_table "regions", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string "title", :limit => 50, :null => false
    t.string "code",  :limit => 10, :null => false
  end

  add_index "states", ["code"], :name => "index_states_on_code", :unique => true
  add_index "states", ["title"], :name => "index_states_on_title", :unique => true

  create_table "user_addresses", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.text     "address2"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",    :null => false
    t.string   "city",       :null => false
    t.string   "state_code", :null => false
    t.string   "zip",        :null => false
  end

  add_index "user_addresses", ["user_id"], :name => "index_user_addresses_on_user_id"

  create_table "user_profiles", :force => true do |t|
    t.integer   "user_id"
    t.string    "phone_number"
    t.string    "profession"
    t.string    "employer"
    t.string    "education"
    t.string    "about2030"
    t.date      "birthdate"
    t.text      "bio"
    t.string    "avatar_file_name"
    t.string    "avatar_content_type"
    t.integer   "avatar_file_size"
    t.timestamp "avatar_updated_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "gender",              :limit => 1
    t.text      "member_notes"
  end

  create_table "users", :force => true do |t|
    t.string    "first_name",                             :null => false
    t.string    "last_name",                              :null => false
    t.string    "url_friendly"
    t.string    "email",                                  :null => false
    t.string    "crypted_password",                       :null => false
    t.string    "password_salt",                          :null => false
    t.string    "persistence_token",                      :null => false
    t.string    "single_access_token",                    :null => false
    t.string    "perishable_token",                       :null => false
    t.integer   "login_count",         :default => 0,     :null => false
    t.integer   "failed_login_count",  :default => 0,     :null => false
    t.timestamp "last_request_at"
    t.timestamp "current_login_at"
    t.timestamp "last_login_at"
    t.string    "current_login_ip"
    t.string    "last_login_ip"
    t.timestamp "joined_at"
    t.timestamp "expired_at"
    t.timestamp "activated_at"
    t.boolean   "active",              :default => false
    t.boolean   "activated",           :default => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.timestamp "last_renewed_at"
  end

end
