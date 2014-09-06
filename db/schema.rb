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

ActiveRecord::Schema.define(version: 20140815150935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.boolean  "service"
    t.integer  "price"
    t.boolean  "deleted",      default: false
    t.integer  "user_id"
    t.integer  "orders_count", default: 0
    t.integer  "total_clicks", default: 0
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
    t.integer  "offer_id"
    t.integer  "clicks",     default: 0
    t.integer  "set_clicks", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "promoted_offers", ["offer_id"], name: "index_promoted_offers_on_offer_id", using: :btree
  add_index "promoted_offers", ["user_id"], name: "index_promoted_offers_on_user_id", using: :btree

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

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "offer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["offer_id"], name: "index_taggings_on_offer_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_identifications", force: true do |t|
    t.string   "real_name"
    t.string   "city"
    t.integer  "zip_code"
    t.string   "address"
    t.string   "country"
    t.string   "id_photo"
    t.string   "recent_photo"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_identifications", ["user_id"], name: "index_user_identifications_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.integer  "credit",                 default: 20
    t.string   "bio"
    t.string   "language"
    t.string   "second_language"
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
