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

ActiveRecord::Schema.define(version: 20160610040630) do

  create_table "academic_hours", force: :cascade do |t|
    t.integer  "teacher_id"
    t.integer  "group_id"
    t.integer  "discipline_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "departments", force: :cascade do |t|
    t.integer  "num",        limit: 5, null: false
    t.string   "title",                null: false
    t.string   "superunit"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "departments", ["num"], name: "index_departments_on_num", unique: true

  create_table "departments_teachers", id: false, force: :cascade do |t|
    t.integer "department_id", null: false
    t.integer "teacher_id",    null: false
  end

  add_index "departments_teachers", ["department_id", "teacher_id"], name: "index_departments_teachers_on_department_id_and_teacher_id", unique: true

  create_table "disciplines", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "tip",        null: false
    t.integer  "plan_id"
    t.integer  "duty_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "disciplines", ["duty_id"], name: "index_disciplines_on_duty_id"
  add_index "disciplines", ["plan_id"], name: "index_disciplines_on_plan_id"

  create_table "disciplines_teachers", id: false, force: :cascade do |t|
    t.integer "discipline_id", null: false
    t.integer "teacher_id",    null: false
  end

  create_table "documents", force: :cascade do |t|
    t.text     "text"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "duties", force: :cascade do |t|
    t.integer  "discipline_id", null: false
    t.integer  "document_id"
    t.text     "name",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "student_id"
  end

  add_index "duties", ["discipline_id", "document_id", "name"], name: "duties_index", unique: true

  create_table "groups", force: :cascade do |t|
    t.string   "title",         null: false
    t.integer  "course",        null: false
    t.integer  "semester",      null: false
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "groups", ["department_id"], name: "index_groups_on_department_id"
  add_index "groups", ["title"], name: "index_groups_on_title", unique: true

  create_table "groups_plans", id: false, force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "plan_id",  null: false
  end

  add_index "groups_plans", ["group_id", "plan_id"], name: "index_groups_plans_on_group_id_and_plan_id", unique: true

  create_table "plans", force: :cascade do |t|
    t.integer "specialty_id"
    t.string  "learn_form"
    t.integer "learn_period"
  end

  create_table "role_users", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "role_users", ["role_id"], name: "index_role_users_on_role_id"
  add_index "role_users", ["user_id"], name: "index_role_users_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.text     "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialties", force: :cascade do |t|
    t.string   "code",       limit: 10, null: false
    t.string   "gen",                   null: false
    t.string   "title",                 null: false
    t.string   "level",                 null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "specialties", ["code"], name: "index_specialties_on_code", unique: true

  create_table "student_honors", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "student_id"
  end

  create_table "student_works", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "title"
    t.string   "description"
    t.boolean  "visited"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "discipline_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "status"
  end

  create_table "students", force: :cascade do |t|
    t.string   "l_n",                 null: false
    t.string   "f_n",                 null: false
    t.string   "s_n"
    t.date     "birth",               null: false
    t.integer  "studbook",            null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "about"
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "students", ["group_id"], name: "index_students_on_group_id"
  add_index "students", ["studbook"], name: "index_students_on_studbook", unique: true
  add_index "students", ["user_id"], name: "index_students_on_user_id"

  create_table "teachers", force: :cascade do |t|
    t.string   "lname",               null: false
    t.string   "fname",               null: false
    t.string   "sname"
    t.date     "birth",               null: false
    t.string   "degree",              null: false
    t.text     "rank",                null: false
    t.text     "post",                null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "teachers", ["user_id"], name: "index_teachers_on_user_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                                       null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.integer  "failed_logins_count",             default: 0
    t.datetime "lock_expires_at"
    t.string   "unlock_token"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
    t.string   "file"
  end

  add_index "users", ["activation_token"], name: "index_users_on_activation_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["last_logout_at", "last_activity_at"], name: "index_users_on_last_logout_at_and_last_activity_at"
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token"

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
