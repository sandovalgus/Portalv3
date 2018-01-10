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

ActiveRecord::Schema.define(version: 20171010001623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "coordinate_zones", force: :cascade do |t|
    t.float "latitud"
    t.float "longitud"
    t.integer "zone_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zone_id"], name: "index_coordinate_zones_on_zone_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "n_socio"
    t.string "nombre"
    t.string "apellido"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "zone_id"
    t.integer "estado"
    t.date "fecha_vencimiento"
    t.index ["zone_id"], name: "index_customers_on_zone_id"
  end

  create_table "importacions", force: :cascade do |t|
    t.boolean "import"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "imports", force: :cascade do |t|
    t.boolean "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "zones", force: :cascade do |t|
    t.string "nombre_zona"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
