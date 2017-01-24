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

ActiveRecord::Schema.define(version: 20170114005620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flats", force: :cascade do |t|
    t.integer  "floorplan_id"
    t.integer  "bed"
    t.integer  "bath"
    t.string   "stack"
    t.string   "floor"
    t.integer  "sqft"
    t.boolean  "is_active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["floorplan_id"], name: "index_flats_on_floorplan_id", using: :btree
  end

  create_table "floorplans", force: :cascade do |t|
    t.integer  "layout_id"
    t.jsonb    "windows"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "flat_id"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flat_id"], name: "index_listings_on_flat_id", using: :btree
  end

  add_foreign_key "flats", "floorplans"
  add_foreign_key "listings", "flats"
end
