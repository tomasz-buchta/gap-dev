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

ActiveRecord::Schema.define(version: 2019_01_26_154348) do

  create_table "countries", force: :cascade do |t|
    t.string "code", null: false
    t.integer "panel_provider_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", unique: true
    t.index ["panel_provider_id"], name: "index_countries_on_panel_provider_id"
  end

  create_table "countries_target_groups", id: false, force: :cascade do |t|
    t.integer "country_id", null: false
    t.integer "target_group_id", null: false
    t.index ["country_id", "target_group_id"], name: "index_country_on_target_group"
    t.index ["target_group_id", "country_id"], name: "index_target_group_on_country"
  end

  create_table "location_groups", force: :cascade do |t|
    t.string "name"
    t.integer "country_id"
    t.integer "panel_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_location_groups_on_country_id"
    t.index ["panel_provider_id"], name: "index_location_groups_on_panel_provider_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.string "external_id", null: false
    t.string "secret_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "location_group_id"
    t.index ["external_id"], name: "index_locations_on_external_id", unique: true
    t.index ["location_group_id"], name: "index_locations_on_location_group_id"
  end

  create_table "panel_providers", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_panel_providers_on_code", unique: true
  end

  create_table "target_group_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "target_group_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "target_group_desc_idx"
  end

  create_table "target_groups", force: :cascade do |t|
    t.string "name"
    t.string "external_id"
    t.integer "parent_id"
    t.string "secret_code"
    t.integer "panel_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["panel_provider_id"], name: "index_target_groups_on_panel_provider_id"
    t.index ["parent_id"], name: "index_target_groups_on_parent_id"
  end

end
