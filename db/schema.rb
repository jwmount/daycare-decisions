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
    t.string   "street_address",             default: "",                    null: false
    t.string   "locality",                   default: "",                    null: false
    t.string   "state",            limit: 3, default: "",                    null: false
    t.string   "post_code",                  default: ""
    t.float    "lat"
    t.float    "long"
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
    t.string   "jurisdiction"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificates", force: true do |t|
    t.string   "name",                                                  null: false
    t.string   "description"
    t.boolean  "for_person"
    t.boolean  "for_company"
    t.boolean  "for_provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certs", force: true do |t|
    t.integer  "certifiable_id",                                            null: false
    t.string   "certifiable_type",                                          null: false
    t.integer  "certificate_id",                                            null: false
    t.string   "serial_number",                     default: ""
    t.datetime "expires_on"
    t.boolean  "active",                            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

 # add_index "certs", ["certifiable_id", "certifiable_type"], name: "index_certs_on_certifiable_id_and_certifiable_type", using: :btree

=begin
  create_table "children", force: true do |t|
    t.integer  "family_id"
    t.string   "surname"
    t.string   "fist_name"
    t.string   "nick_name"
    t.datetime "born_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
=end
  create_table "companies", force: true do |t|
    t.string   "name",                                null: false
    t.boolean  "active"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

=begin
  create_table "families", force: true do |t|
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
=end

  # Set guardian_handle to be login name and use this to locate the guardian
  # currently logged on.  
  create_table "guardians", force: true do |t|
    t.integer  "waitlist_application_id"
    t.string   "first_name"
    t.string   "family_name"
    t.string   "handle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guardians_providers", force: true, id: false  do |t|
    t.integer "guardian_id",      null: false
    t.integer "provider_id",      null: false
  end
  add_index "guardians_providers", [:guardian_id, :provider_id], name: "index_guardians_providers", using: :btree

  create_table "people", force: true do |t|
    t.integer  "company_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.boolean  "active"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "care",            :default => 't.b.d.'
    t.decimal  "fee",             :default => 0.00
    t.integer  "NQS_rating",      :default => 0
    t.string   "description"
    t.boolean  "disposable_nappies"
    t.boolean  "cloth_nappies"
    t.string   "hours"
    t.string   "age"
    t.string   "url"
    t.string   "language"
    t.boolean  "food_provided" # – Morning Tea, Lunch, Afternoon Tea MVP has Yes or some
    t.boolean  "air_conditioning"
    t.boolean  "bus_service"
    t.boolean  "extended_hours_for_kindys"
    t.boolean  "online_waitlist"
    t.boolean  "online_enrollment"
    t.boolean  "security_access"
    t.boolean  "additional_activities_included" # Drop down menu: Music, Language, sports program, dance program, learning programs 
    t.boolean  "excursions"
    t.boolean  "guest_speakers"
    t.boolean  "outdoor_play_area"  #Amount of Land        Amount or drop down menu?
    t.boolean  "real_grass"
    t.boolean  "technology"  #Technology        Drop down ipad, smart screens (36mths +)
    t.boolean  "sibling_has_priority",   :default => false
    t.boolean  "vacancies"   #Vacancies 0-12mths 13-24mths 25-35 Months 36 Months – Pre-schoolOver Preschool age
    t.decimal  "waitlist_fee"
    t.boolean  "waitlist_fee_refund"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requirements", force: true do |t|
    t.integer  "requireable_id"
    t.string   "requireable_type"
    t.integer  "certificate_id",                                           null: false
    t.integer  "for_person"
    t.integer  "for_company"
    t.integer  "for_provider"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name",                                                      null:false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolodexes", force: true do |t|
    t.integer  "rolodexable_id",                                            null: false
    t.string   "rolodexable_type",                                          null: false
    t.string   "number_or_email",                    default: ""
    t.string   "kind",                               default: ""
    t.string   "when_to_use",                        default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

=begin  No need now
  create_table "services", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
=end
create_table "waitlist_applications", force: true do |t|
    t.integer  "guardian_id"
    t.integer  "provider_id",                          null: false
    t.datetime "lodged_on"
    t.string   "lodged_by"
    t.integer  "lodged_for"
    t.integer  "active",         defalut: true,        null: false
    t.string   "form_name",      default: 'master'

    t.string    "enrolment_goal"
    t.datetime  "enrolment_goal_date"
    t.datetime  "enroled_on"
    t.string    "gender"
    t.datetime  "dob" 
    t.string    "born_country"
    t.datetime  "confined_on"
    t.string    "languages_spoken_at_home"
    t.string    "special_needs"
    t.string    "cultural_needs"

    t.string    "mothers_name"
    t.string    "mothers_occupation"
    t.time      "mothers_hours_of_work"   
    t.string    "mothers_employer"
    t.string    "mothers_employment_status"   
    t.boolean   "mother_is_aboriginal_descent"
    t.boolean   "mother_has_other_children"
    t.integer   "mother_dependents_count"

    t.string    "fathers_name"
    t.string    "fathers_occupation"
    t.time      "fathers_hours_of_work"
    t.string    "fathers_employer"
    t.string    "fathers_employment_status"
    t.boolean   "father_is_aboriginal_descent"
    t.boolean   "father_has_other_children"
    t.integer   "father_dependents_count"

    t.integer   "number_care_days_required"
    t.boolean   "care_day_sunday"
    t.boolean   "care_day_monday"
    t.boolean   "care_day_tuesday"
    t.boolean   "care_day_wednesday"
    t.boolean   "care_day_thursday"
    t.boolean   "care_day_friday"
    t.boolean   "care_day_saturday"
    t.boolean   "will_accept_available"
    
    t.string    "special_circumstances"

    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
