require "active_record"

class CreateInitialTables < ActiveRecord::Migration
   def self.up
      create_table :weapons do |table|
         table.column :name, :string
         table.column :description, :string
      end

      create_table :players do |table|
         table.column :real_name, :string
         table.column :service_tag, :string
      end

      create_table :player_effectivenesses do |table|
         table.column :team_size, :integer
         table.column :team_score, :integer
         table.column :other_team_size, :integer
         table.column :other_team_score, :integer

         table.references :player         
         table.references :reach_map
      end

      create_table :kill_death_spreads do |table|
         table.column :kills, :integer
         table.column :deaths, :integer
         table.column :spread, :integer

         table.references :player
      end

      create_table :reach_maps do |table|
         table.column :name, :string
      end

      create_table :reach_player_stats do |table|
         table.column :assists, :integer
         table.column :average_death_distance, :number
         table.column :average_kill_distance, :number
         table.column :betrayals, :integer
         table.column :did_not_finish, :boolean
         table.column :deaths, :integer
         table.column :head_shots, :integer
         table.column :overall_standing, :integer
         table.column :kills, :integer
         table.column :total_medals, :integer

         table.references :player
         table.references :reach_team
         # table.references :weapon_carnage
      end

      create_table :reach_teams do |table|
         table.column :team_id, :integer
         table.column :standing, :integer
         table.column :score, :integer
         table.column :kills, :integer
         table.column :assists, :integer
         table.column :betrayals, :integer
         table.column :suicides, :integer
         table.column :medals, :integer

         table.references :reach_game
         table.references :reach_players
      end

      create_table :reach_games do |table|
         table.column :reach_id, :string
         table.column :name, :string
         table.column :duration, :string
         table.column :timestamp, :datetime

         table.references :reach_map
         table.references :reach_teams
      end
   end

   def self.down
      drop_table :weapons
      drop_table :players
      drop_table :player_effectivenesses
      drop_table :kill_death_spreads
      drop_table :reach_games
      drop_table :reach_maps
   end
end
