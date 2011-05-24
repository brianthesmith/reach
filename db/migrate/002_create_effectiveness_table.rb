require "active_record"

class CreateEffectivenessTable < ActiveRecord::Migration
   def self.up
      create_table :player_effectivenesses do |table|
         table.column :service_tag, :string
         table.column :map, :string
         table.column :team_size, :integer
         table.column :team_score, :integer
         table.column :other_team_size, :integer
         table.column :other_team_score, :integer
      end
   end

   def self.down
      drop_table :player_effectivenesses
   end
end
