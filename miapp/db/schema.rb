# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_18_014432) do
  create_table "options", force: :cascade do |t|
    t.integer "question_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "progress", force: :cascade do |t|
    t.integer "user_id"
    t.integer "correctAnswers"
    t.integer "incorrectAnswers"
    t.integer "losePoints"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_progress_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.integer "difficult"
    t.integer "cantPoints"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "user_id"
    t.string "description"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "responses", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_responses_on_option_id"
    t.index ["user_id"], name: "index_responses_on_user_id"
  end

  create_table "suggestions", force: :cascade do |t|
    t.integer "user_id"
    t.string "description"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_suggestions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "pass"
    t.integer "lifes"
    t.integer "points"
    t.integer "streak"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_questions", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "questions_id"
    t.index ["questions_id"], name: "index_users_questions_on_questions_id"
    t.index ["user_id"], name: "index_users_questions_on_user_id"
  end

end
