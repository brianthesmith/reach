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

      create_table :player_statistics do |table|
         table.column :reach_game_id, :string
         table.column :service_tag, :string
         table.column :game_type, :string
         table.column :game_time, :datetime
         table.column :kills, :number
         table.column :deaths, :number
         table.column :assists, :number
         table.column :total_medals, :number
         table.column :weapon_of_choice, :number
         table.column :weapon_most_killed_by, :number
         table.column :on_winning_team, :boolean
         table.column :total_head_shots, :number
      end
   end

   def self.down
      drop_table :weapons
      drop_table :players
      drop_table :player_statistics
   end
end
