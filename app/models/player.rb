class Player < ActiveRecord::Base
   def self.find_by_service_tag(service_tag)
      where(:service_tag => service_tag).first
   end
end
