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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "player_statistics", :force => true do |t|
    t.string   "reach_game_id"
    t.string   "service_tag"
    t.string   "game_type"
    t.datetime "game_time"
    t.integer  "kills"
    t.integer  "deaths"
    t.integer  "assists"
    t.integer  "total_medals"
    t.integer  "weapon_of_choice"
    t.integer  "weapon_most_killed_by"
    t.boolean  "on_winning_team"
    t.integer  "total_head_shots"
  end

  create_table "players", :force => true do |t|
    t.string "real_name"
    t.string "service_tag"
  end

  create_table "weapons", :force => true do |t|
    t.string "name"
    t.string "description"
  end

end
