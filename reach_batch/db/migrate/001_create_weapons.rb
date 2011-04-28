require "active_record"

class CreateWeapons < ActiveRecord::Migration
   def self.up
      create_table :weapons do |table|
         table.column :id, :number, :null => false
         table.column :name, :string, :null => false
         table.column :description, :string, :null => false
      end
   end

   def self.down
      drop_table :weapons
   end
end
