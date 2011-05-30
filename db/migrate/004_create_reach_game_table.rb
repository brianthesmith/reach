require "active_record"

class CreateReachGameTable < ActiveRecord::Migration
   def self.up
      create_table :maps do |table|
         table.column :name, :string
         table.column :base_map, :string
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
         table.column :emblem, :string
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
         table.column :duration, :string
         table.column :timestamp, :datetime
         table.column :variant_class, :string

         table.references :map
         table.references :reach_teams
      end
   end

   def self.down
      drop_table :games
      drop_table :maps
      drop_table :player_statistics
   end
end
