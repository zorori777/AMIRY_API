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

ActiveRecord::Schema.define(version: 20171028130106) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", limit: 1, default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "article_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "article_id", null: false
    t.string "content", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["user_id"], name: "index_article_comments_on_user_id"
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.string "title", default: "", null: false
    t.text "content", null: false
    t.integer "updated_times", default: 0, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["created_at"], name: "index_articles_on_created_at"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "band_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "band_id", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["band_id", "name"], name: "index_band_images_on_band_id_and_name", unique: true
  end

  create_table "band_lives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "band_id", null: false
    t.integer "live_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "bands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "circle_id", null: false
    t.string "name", default: "", null: false
    t.string "concept", default: "", null: false
    t.text "description", null: false
    t.integer "people_num", default: 0, null: false, unsigned: true
    t.integer "type", limit: 1, default: 0, null: false, unsigned: true
    t.datetime "united_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["circle_id", "name"], name: "index_bands_on_circle_id_and_name", unique: true
  end

  create_table "circle_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "circle_id", null: false
    t.string "name", default: "", null: false
    t.integer "type", default: 0, null: false, unsigned: true
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["circle_id", "name"], name: "index_circle_images_on_circle_id_and_name", unique: true
  end

  create_table "circles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "university_id", null: false
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "members_count", default: 0, null: false, unsigned: true
    t.integer "bands_count", default: 0, null: false, unsigned: true
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name", "university_id"], name: "index_circles_on_name_and_university_id", unique: true
  end

  create_table "introductions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sender_id", null: false, comment: "bigint活用のため、limit: 8"
    t.bigint "recipient_id", null: false, comment: "bigint活用のため、limit: 8"
    t.text "description", null: false
    t.integer "acceptance", limit: 1, default: 0, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["sender_id", "recipient_id"], name: "index_introductions_on_sender_id_and_recipient_id", unique: true
  end

  create_table "lectures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.string "title", default: "", null: false
    t.text "description", null: false
    t.string "address", default: "", null: false
    t.datetime "hold_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["hold_at"], name: "index_lectures_on_hold_at"
    t.index ["title"], name: "index_lectures_on_title", unique: true
    t.index ["user_id"], name: "index_lectures_on_user_id"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sender_id", null: false, comment: "bigint活用のため、limit: 8"
    t.bigint "recipient_id", null: false, comment: "bigint活用のため、limit: 8"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["sender_id", "recipient_id"], name: "index_likes_on_sender_id_and_recipient_id", unique: true
  end

  create_table "live_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "live_id", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["live_id", "name"], name: "index_live_images_on_live_id_and_name", unique: true
  end

  create_table "lives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "circle_id", null: false
    t.string "name", default: "", null: false
    t.text "description", null: false
    t.integer "max_capacity", default: 0, null: false, unsigned: true
    t.integer "reservations_count", default: 0, null: false, unsigned: true
    t.integer "type", default: 0, null: false, comment: "サークルライブ: 1, サークルライブ以外: 2", unsigned: true
    t.datetime "hold_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["circle_id", "type"], name: "index_lives_on_circle_id_and_type"
    t.index ["hold_at"], name: "index_lives_on_hold_at"
  end

  create_table "matchings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "like_id", null: false
    t.integer "user_id", null: false
    t.integer "acceptance", limit: 1, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["like_id", "user_id"], name: "index_matchings_on_like_id_and_user_id", unique: true
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sender_id", null: false, comment: "bigint活用のため、limit: 8"
    t.bigint "recipient_id", null: false, comment: "bigint活用のため、limit: 8"
    t.string "body", default: "", null: false
    t.string "image", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["recipient_id"], name: "index_messages_on_recipient_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "parts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "name", default: 0, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "index_parts_on_name", unique: true
  end

  create_table "universities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "index_universities_on_name", unique: true
  end

  create_table "user_bands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "band_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "user_circles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "circle_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "user_lives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "live_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["live_id"], name: "index_user_lives_on_live_id"
    t.index ["user_id"], name: "index_user_lives_on_user_id"
  end

  create_table "user_parts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "part_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "university_id", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "display_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "avatar", default: "", null: false
    t.string "catchcopy", default: "", null: false
    t.text "self_introduction", null: false
    t.integer "bands_count", default: 0, null: false
    t.integer "received_likes_count", default: 0, null: false
    t.integer "sendable_likes_count", default: 0, null: false
    t.integer "matchings_count", default: 0, null: false
    t.integer "account_status", default: 0, null: false
    t.string "provider", default: "", null: false
    t.string "uid", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["display_name"], name: "index_users_on_display_name", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
