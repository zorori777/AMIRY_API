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

ActiveRecord::Schema.define(version: 20171008112225) do

  create_table "article_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "article_id", null: false
    t.string "content", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["article_id"], name: "index_article_comments_on_article_id"
    t.index ["user_id"], name: "index_article_comments_on_user_id"
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.text "content", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["created_at"], name: "index_articles_on_created_at"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "band_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "band_id", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["band_id"], name: "index_band_images_on_band_id"
  end

  create_table "band_lives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "band_id", null: false
    t.bigint "live_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["band_id"], name: "index_band_lives_on_band_id"
    t.index ["live_id"], name: "index_band_lives_on_live_id"
  end

  create_table "bands", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "circle_id", null: false
    t.string "name", default: "", null: false
    t.string "concept", default: "", null: false
    t.text "description", null: false
    t.integer "people_num", default: 0, null: false, unsigned: true
    t.integer "type", limit: 1, default: 0, null: false, unsigned: true
    t.datetime "united_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["circle_id", "name"], name: "index_bands_on_circle_id_and_name", unique: true
    t.index ["circle_id"], name: "index_bands_on_circle_id"
  end

  create_table "circle_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "circle_id", null: false
    t.string "name", default: "", null: false
    t.integer "type", default: 0, null: false, unsigned: true
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["circle_id"], name: "index_circle_images_on_circle_id"
  end

  create_table "circles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "university_id", null: false
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "members_count", default: 0, null: false, unsigned: true
    t.integer "bands_count", default: 0, null: false, unsigned: true
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name", "university_id"], name: "index_circles_on_name_and_university_id", unique: true
    t.index ["university_id"], name: "index_circles_on_university_id"
  end

  create_table "lectures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.text "description", null: false
    t.string "address", default: "", null: false
    t.datetime "hold_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["hold_at"], name: "index_lectures_on_hold_at"
    t.index ["user_id"], name: "index_lectures_on_user_id"
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sender_id", null: false, comment: "bigint活用のため、limit: 8"
    t.bigint "recipient_id", null: false, comment: "bigint活用のため、limit: 8"
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["recipient_id"], name: "fk_rails_e63dc1dc05"
    t.index ["sender_id"], name: "fk_rails_1c99703fe0"
  end

  create_table "live_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "live_id", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["live_id"], name: "index_live_images_on_live_id"
  end

  create_table "lives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "circle_id", null: false
    t.string "name", default: "", null: false
    t.text "description", null: false
    t.integer "max_capacity", default: 0, null: false, unsigned: true
    t.integer "reservations_count", default: 0, null: false, unsigned: true
    t.integer "type", default: 0, null: false, comment: "サークルライブ: 1, サークルライブ以外: 2", unsigned: true
    t.datetime "hold_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["circle_id", "type"], name: "index_lives_on_circle_id_and_type"
    t.index ["circle_id"], name: "index_lives_on_circle_id"
    t.index ["hold_at"], name: "index_lives_on_hold_at"
  end

  create_table "matchings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "like_id", null: false
    t.bigint "user_id", null: false
    t.integer "acceptance", limit: 1, null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["like_id"], name: "index_matchings_on_like_id"
    t.index ["user_id"], name: "index_matchings_on_user_id"
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "sender_id", null: false, comment: "bigint活用のため、limit: 8"
    t.bigint "recipient_id", null: false, comment: "bigint活用のため、limit: 8"
    t.string "body", default: "NO BOBY", null: false
    t.string "image", default: "NO IMAGE", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["recipient_id"], name: "fk_rails_12e9de2e48"
    t.index ["sender_id"], name: "fk_rails_b8f26a382d"
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
    t.bigint "user_id", null: false
    t.bigint "band_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["band_id"], name: "index_user_bands_on_band_id"
    t.index ["user_id"], name: "index_user_bands_on_user_id"
  end

  create_table "user_circles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "circle_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["circle_id"], name: "index_user_circles_on_circle_id"
    t.index ["user_id"], name: "index_user_circles_on_user_id"
  end

  create_table "user_lives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "live_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["live_id"], name: "index_user_lives_on_live_id"
    t.index ["user_id"], name: "index_user_lives_on_user_id"
  end

  create_table "user_parts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "part_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["part_id"], name: "index_user_parts_on_part_id"
    t.index ["user_id"], name: "index_user_parts_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "university_id", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "avatar", default: "", null: false
    t.string "catchcopy", default: "", null: false
    t.text "self_introduction", null: false
    t.integer "bands_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "mathcings_count", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["university_id"], name: "index_users_on_university_id"
  end

  add_foreign_key "article_comments", "articles"
  add_foreign_key "article_comments", "users"
  add_foreign_key "articles", "users"
  add_foreign_key "band_images", "bands"
  add_foreign_key "band_lives", "bands"
  add_foreign_key "band_lives", "lives", column: "live_id"
  add_foreign_key "bands", "circles"
  add_foreign_key "circle_images", "circles"
  add_foreign_key "circles", "universities"
  add_foreign_key "lectures", "users"
  add_foreign_key "likes", "users", column: "recipient_id"
  add_foreign_key "likes", "users", column: "sender_id"
  add_foreign_key "live_images", "lives", column: "live_id"
  add_foreign_key "lives", "circles"
  add_foreign_key "matchings", "likes"
  add_foreign_key "matchings", "users"
  add_foreign_key "messages", "users", column: "recipient_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "user_bands", "bands"
  add_foreign_key "user_bands", "users"
  add_foreign_key "user_circles", "circles"
  add_foreign_key "user_circles", "users"
  add_foreign_key "user_lives", "lives", column: "live_id"
  add_foreign_key "user_lives", "users"
  add_foreign_key "user_parts", "parts"
  add_foreign_key "user_parts", "users"
  add_foreign_key "users", "universities"
end
