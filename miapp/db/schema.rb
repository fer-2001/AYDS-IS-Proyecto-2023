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

ActiveRecord::Schema[7.0].define(version: 2023_09_21_152223) do
  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.integer "price", default: 10
    t.boolean "available", default: true
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leaderboards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leaderboards_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.integer "question_id"
    t.string "content"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "progresses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "current_question", default: 0
    t.integer "correct_answers", default: 0
    t.integer "incorrect_answers", default: 0
    t.integer "lose_points", default: 0
    t.integer "points", default: 0
    t.integer "question_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_progresses_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.integer "difficult"
    t.integer "cantPoints"
    t.string "curiosities"
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
    t.string "password"
    t.integer "lifes", default: 5
    t.integer "points", default: 0
    t.integer "streak", default: 0
    t.integer "coins", default: 0
    t.string "card", default: "card"
    t.string "role", default: "clasificado"
    t.string "password_digest"
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
