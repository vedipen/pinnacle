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

ActiveRecord::Schema.define(version: 20180116091434) do

  create_table "anti_viri", force: :cascade do |t|
    t.integer "teamowner_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_anti_viri_on_post_id"
    t.index ["teamowner_id"], name: "index_anti_viri_on_teamowner_id"
  end

  create_table "bets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_bets_on_post_id"
    t.index ["team_id"], name: "index_bets_on_team_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "post_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hiddens", force: :cascade do |t|
    t.integer "amount"
    t.integer "teamowner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.integer "post_id"
    t.index ["post_id"], name: "index_hiddens_on_post_id"
    t.index ["team_id"], name: "index_hiddens_on_team_id"
    t.index ["teamowner_id"], name: "index_hiddens_on_teamowner_id"
  end

  create_table "pmcmembers", force: :cascade do |t|
    t.text "aboutme"
    t.integer "seniority"
    t.integer "age"
    t.string "education"
    t.string "nick_name"
    t.string "room"
    t.string "phone"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "team_id"
    t.index ["team_id"], name: "index_pmcmembers_on_team_id"
    t.index ["user_id"], name: "index_pmcmembers_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "duration"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.boolean "events", default: true
    t.boolean "hidden_transactions", default: true
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.text "about_me"
    t.text "strengths"
    t.text "weakness"
    t.integer "seniority"
    t.integer "age"
    t.string "education"
    t.string "nick_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "room"
    t.string "phone"
    t.string "availability"
    t.integer "team_id"
    t.integer "base_price", default: 10
    t.integer "sell_price", default: 0
    t.index ["team_id"], name: "index_profiles_on_team_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "teamowners", force: :cascade do |t|
    t.text "aboutme"
    t.integer "seniority"
    t.integer "age"
    t.string "education"
    t.string "nick_name"
    t.string "room"
    t.string "phone"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "hidden_points", default: 75
    t.integer "hidden_virus", default: 2
    t.integer "hidden_antivirus", default: 1
    t.index ["user_id"], name: "index_teamowners_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.text "about_team"
    t.integer "teamowner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "initial_price", default: 200
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["teamowner_id"], name: "index_teams_on_teamowner_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.string "name", null: false
    t.string "usertype"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "viri", force: :cascade do |t|
    t.integer "teamowner_id"
    t.integer "team_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_viri_on_post_id"
    t.index ["team_id"], name: "index_viri_on_team_id"
    t.index ["teamowner_id"], name: "index_viri_on_teamowner_id"
  end

  create_table "votes", force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

end
