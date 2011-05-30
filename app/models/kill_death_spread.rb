class KillDeathSpread < ActiveRecord::Base
   belongs_to :player

   def self.find_by_service_tag(service_tag)
      includes(:player).where(:players => {:service_tag => service_tag})
   end
end
