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

ActiveRecord::Schema.define(version: 20140915221042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "alerts", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerts", ["user_id"], name: "index_alerts_on_user_id", using: :btree

  create_table "buy_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.integer  "buyable_id"
    t.string   "buyable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buy_requests", ["buyable_id", "buyable_type"], name: "index_buy_requests_on_buyable_id_and_buyable_type", using: :btree
  add_index "buy_requests", ["conversation_id"], name: "index_buy_requests_on_conversation_id", using: :btree
  add_index "buy_requests", ["user_id"], name: "index_buy_requests_on_user_id", using: :btree

  create_table "conversations", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.integer  "messages_count",     default: 0
    t.datetime "content_changed_at"
    t.integer  "buy_requests_count", default: 0
    t.integer  "orders_count",       default: 0
    t.integer  "reviews_count",      default: 0
    t.integer  "convoable_id"
    t.string   "convoable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["convoable_id", "convoable_type"], name: "index_conversations_on_convoable_id_and_convoable_type", using: :btree
  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["user_id"], name: "index_conversations_on_user_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.string   "location"
    t.string   "tag_list"
    t.boolean  "deleted"
    t.boolean  "remote"
    t.integer  "user_id"
    t.integer  "total_clicks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "conversation_id"
    t.text     "body"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "offers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.string   "image_a"
    t.string   "image_b"
    t.string   "image_c"
    t.string   "image_d"
    t.string   "image_e"
    t.string   "location"
    t.string   "tag_list"
    t.boolean  "new"
    t.boolean  "sell"
    t.decimal  "price"
    t.boolean  "deleted",       default: false
    t.integer  "user_id"
    t.integer  "orders_count",  default: 0
    t.integer  "total_clicks",  default: 0
    t.integer  "quantity",      default: 1
    t.integer  "barcode"
    t.boolean  "free_delivery", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["user_id"], name: "index_offers_on_user_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "reviews_count",   default: 0
    t.integer  "orderable_id"
    t.string   "orderable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["buyer_id"], name: "index_orders_on_buyer_id", using: :btree
  add_index "orders", ["conversation_id"], name: "index_orders_on_conversation_id", using: :btree
  add_index "orders", ["orderable_id", "orderable_type"], name: "index_orders_on_orderable_id_and_orderable_type", using: :btree
  add_index "orders", ["seller_id"], name: "index_orders_on_seller_id", using: :btree

  create_table "phone_codes", force: true do |t|
    t.string   "code"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phone_codes", ["user_id"], name: "index_phone_codes_on_user_id", using: :btree

  create_table "phone_verifications", force: true do |t|
    t.string   "number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phone_verifications", ["user_id"], name: "index_phone_verifications_on_user_id", using: :btree

  create_table "promoted_offers", force: true do |t|
    t.integer  "user_id"
    t.integer  "clicks",     default: 0
    t.integer  "set_clicks", default: 0
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promoted_offers", ["offer_id"], name: "index_promoted_offers_on_offer_id", using: :btree
  add_index "promoted_offers", ["user_id"], name: "index_promoted_offers_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "reviews", force: true do |t|
    t.boolean  "positive"
    t.text     "body"
    t.text     "proof"
    t.string   "image"
    t.integer  "offer_id"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.integer  "order_id"
    t.integer  "conversation_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["buyer_id"], name: "index_reviews_on_buyer_id", using: :btree
  add_index "reviews", ["conversation_id"], name: "index_reviews_on_conversation_id", using: :btree
  add_index "reviews", ["offer_id"], name: "index_reviews_on_offer_id", using: :btree
  add_index "reviews", ["order_id"], name: "index_reviews_on_order_id", using: :btree
  add_index "reviews", ["reviewable_id", "reviewable_type"], name: "index_reviews_on_reviewable_id_and_reviewable_type", using: :btree
  add_index "reviews", ["seller_id"], name: "index_reviews_on_seller_id", using: :btree

  create_table "services", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "image"
    t.string   "location"
    t.string   "tag_list"
    t.decimal  "price"
    t.boolean  "deleted"
    t.integer  "user_id"
    t.integer  "total_clicks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.text     "bio"
    t.string   "public_location"
    t.boolean  "admin"
    t.boolean  "banned"
    t.string   "image"
    t.integer  "sms_code"
    t.datetime "last_seen_at"
    t.datetime "last_visited_inbox_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
