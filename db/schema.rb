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

ActiveRecord::Schema.define(version: 20171008064149) do

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circle_id", "name"], name: "index_bands_on_circle_id_and_name", unique: true
    t.index ["circle_id"], name: "index_bands_on_circle_id"
  end

  create_table "circle_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "circle_id", null: false
    t.string "name", default: "", null: false
    t.integer "type", default: 0, null: false, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circle_id"], name: "index_circle_images_on_circle_id"
  end

  create_table "circles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "university_id", null: false
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.integer "members_count", default: 0, null: false, unsigned: true
    t.integer "bands_count", default: 0, null: false, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "university_id"], name: "index_circles_on_name_and_university_id", unique: true
    t.index ["university_id"], name: "index_circles_on_university_id"
  end

  create_table "lives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "circle_id", null: false
    t.string "name", default: "", null: false
    t.text "description", null: false
    t.integer "max_capacity", default: 0, null: false, unsigned: true
    t.integer "reservations_count", default: 0, null: false, unsigned: true
    t.integer "type", default: 0, null: false, comment: "サークルライブ: 1, サークルライブ以外: 2", unsigned: true
    t.datetime "hold_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["circle_id", "type"], name: "index_lives_on_circle_id_and_type"
    t.index ["circle_id"], name: "index_lives_on_circle_id"
    t.index ["hold_at"], name: "index_lives_on_hold_at"
  end

  create_table "universities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "index_universities_on_name", unique: true
  end

  add_foreign_key "band_images", "bands"
  add_foreign_key "band_lives", "bands"
  add_foreign_key "band_lives", "lives", column: "live_id"
  add_foreign_key "bands", "circles"
  add_foreign_key "circle_images", "circles"
  add_foreign_key "circles", "universities"
  add_foreign_key "lives", "circles"
end
