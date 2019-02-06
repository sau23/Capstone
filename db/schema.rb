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

ActiveRecord::Schema.define(version: 2019_02_06_211352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.string "user_id"
    t.text "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.boolean "survey_id"
    t.integer "question_id"
    t.text "question"
    t.text "option_1"
    t.text "option_2"
    t.text "option_3"
    t.text "option_4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", force: :cascade do |t|
    t.boolean "survey_id"
    t.integer "question_id"
    t.string "user_id"
    t.integer "response"
    t.text "response_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "user_id"
    t.text "gender"
    t.integer "age"
    t.text "department"
    t.text "clinical_year"
    t.integer "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
