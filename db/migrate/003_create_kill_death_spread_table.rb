require "active_record"

class CreateKillDeathSpreadTable < ActiveRecord::Migration
   def self.up
      create_table :kill_death_spreads do |table|
         table.column :service_tag, :string
         table.column :kills, :integer
         table.column :deaths, :integer
         table.column :spread, :integer
      end
   end

   def self.down
      drop_table :kill_death_spreads
   end
end
