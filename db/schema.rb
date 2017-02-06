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

ActiveRecord::Schema.define(version: 20170206224258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservations", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "city"
    t.string   "address1"
    t.string   "address2"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.boolean  "consent_to_email", default: true, null: false
    t.text     "message"
    t.integer  "admin_id"
    t.datetime "tour_date"
    t.string   "tour_time"
    t.integer  "party_size",                      null: false
    t.integer  "children_u12"
    t.string   "maui_stay"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
