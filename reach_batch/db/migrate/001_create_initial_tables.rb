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
         table.column :kills, :integer
         table.column :deaths, :integer
         table.column :assists, :integer
         table.column :total_medals, :integer
         table.column :weapon_of_choice, :integer
         table.column :weapon_most_killed_by, :integer
         table.column :on_winning_team, :boolean
         table.column :total_head_shots, :integer
      end
   end

   def self.down
      drop_table :weapons
      drop_table :players
      drop_table :player_statistics
   end
end
