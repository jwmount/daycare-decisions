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

ActiveRecord::Schema.define(version: 20140210051608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

 create_table "addresses", force: true do |t|
    t.integer  "addressable_id",                                             null: false
    t.string   "addressable_type",                                           null: false
    t.string   "street",                     default: "",                    null: false
    t.string   "city",                       default: "",                    null: false
    t.string   "state",            limit: 2, default: "",                    null: false
    t.string   "post_code",                  default: "",                    null: false
    t.integer  "lat",                        default: "",                    null: false
    t.integer  "long",                       default: "",                    null: false
    t.datetime "created_at",                 default: '2013-10-08 00:00:00', null: false
    t.datetime "updated_at",                 default: '2013-10-08 00:00:00', null: false
  end

  create_table "admin_users", force: true do |t|
    t.integer  "role_id",                             null: false
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "agencies", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "governing_body"
    t.string   "jurisdiction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificates", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.string   "description"
    t.boolean  "for_person"
    t.boolean  "for_company"
    t.boolean  "for_provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certs", force: true do |t|
    t.integer  "certifiable_id"
    t.string   "certifiable_type"
    t.datetime "expires_on"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "certs", ["certifiable_id", "certifiable_type"], name: "index_certs_on_certifiable_id_and_certifiable_type", using: :btree

  create_table "children", force: true do |t|
    t.string   "surname"
    t.string   "fist_name"
    t.string   "nick_name"
    t.datetime "born_on"
    t.integer  "family_id"
    t.string   "family_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "children", ["family_id", "family_type"], name: "index_children_on_family_id_and_family_type", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "families", force: true do |t|
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.integer  "company_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.integer  "provider_id"
    t.boolean  "available"
    t.datetime "available_on"
    t.boolean  "OK_to_contact"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "type_of_care"
    t.string   "NQS_rating"
    t.string   "languages"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requirements", force: true do |t|
    t.integer  "requireable_id"
    t.string   "requireable_type"
    t.integer  "certificate_id"
    t.integer  "for_person"
    t.integer  "for_company"
    t.integer  "for_provider"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolodexes", force: true do |t|
    t.integer  "rolodexable_id"
    t.string   "rolodexable_type"
    t.string   "number_or_email"
    t.string   "kind"
    t.string   "when_to_use"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end


  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
