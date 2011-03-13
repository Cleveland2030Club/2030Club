# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100928025043) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url_friendly"
    t.text     "description"
    t.boolean  "sponsored"
    t.integer  "max_attendance"
    t.string   "sponsor_file_name"
    t.string   "sponsor_content_type"
    t.integer  "sponsor_file_size"
    t.datetime "sponsor_updated_at"
  end

  create_table "guests", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "product_id",                                 :null => false
    t.string   "product_type",                               :null => false
    t.string   "name",                                       :null => false
    t.decimal  "price",        :precision => 8, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id",   :null => false
    t.integer  "item_id",    :null => false
    t.integer  "quantity",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "customer_id",                                                       :null => false
    t.string   "customer_type",                                                     :null => false
    t.decimal  "amount",           :precision => 8, :scale => 2,                    :null => false
    t.string   "express_token"
    t.string   "express_payer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete",                                       :default => false
  end

  create_table "registrations", :force => true do |t|
    t.integer  "user_id"
    t.string   "email",        :null => false
    t.string   "first_name",   :null => false
    t.string   "last_name",    :null => false
    t.string   "address"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone_number"
    t.string   "profession"
    t.string   "employer"
    t.string   "education"
    t.string   "about2030"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", :force => true do |t|
    t.string "title", :limit => 50, :null => false
    t.string "code",  :limit => 10, :null => false
  end

  add_index "states", ["code"], :name => "index_states_on_code", :unique => true
  add_index "states", ["title"], :name => "index_states_on_title", :unique => true

  create_table "user_addresses", :force => true do |t|
    t.integer  "user_id",                            :null => false
    t.text     "address2"
    t.integer  "address_type_id",                    :null => false
    t.boolean  "is_primary",      :default => false
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address",                            :null => false
    t.string   "city",                               :null => false
    t.string   "state_code",                         :null => false
    t.string   "zip",                                :null => false
  end

  add_index "user_addresses", ["address_type_id"], :name => "index_user_addresses_on_address_type_id"
  add_index "user_addresses", ["user_id"], :name => "index_user_addresses_on_user_id"

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "phone_number"
    t.string   "profession"
    t.string   "employer"
    t.string   "education"
    t.string   "about2030"
    t.date     "birthdate"
    t.text     "bio"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender",              :limit => 1
    t.text     "member_notes"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",                             :null => false
    t.string   "last_name",                              :null => false
    t.string   "url_friendly"
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "joined_at"
    t.datetime "expired_at"
    t.datetime "activated_at"
    t.boolean  "active",              :default => false
    t.boolean  "activated",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
