class PlayerEffectiveness < ActiveRecord::Base
   belongs_to :player
   belongs_to :map

   def self.find_by_service_tag(service_tag)
      joins(:player, :map).where(:players => {:service_tag => service_tag})
   end
end
