class Map < ActiveRecord::Base
   def self.find_by_name(name)
      where(:name => name).first
   end
end
