# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_14_064144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'title'
    t.string 'description'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'maintenances', force: :cascade do |t|
    t.integer 'km'
    t.date 'date'
    t.float 'price'
    t.text 'description'
    t.bigint 'vehicle_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['vehicle_id'], name: 'index_maintenances_on_vehicle_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.integer 'km'
    t.integer 'day'
    t.bigint 'vehicle_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['vehicle_id'], name: 'index_notifications_on_vehicle_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'authentication_token', limit: 30
    t.string 'password_digest'
    t.index ['authentication_token'], name: 'index_users_on_authentication_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'vehicles', force: :cascade do |t|
    t.text 'description'
    t.float 'price'
    t.date 'buy_date'
    t.string 'make_year'
    t.bigint 'category_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.text 'images'
    t.string 'title'
    t.integer 'km_driven'
    t.index ['category_id'], name: 'index_vehicles_on_category_id'
    t.index ['user_id'], name: 'index_vehicles_on_user_id'
  end

  add_foreign_key 'maintenances', 'vehicles'
  add_foreign_key 'notifications', 'vehicles'
  add_foreign_key 'vehicles', 'categories'
  add_foreign_key 'vehicles', 'users'
end
