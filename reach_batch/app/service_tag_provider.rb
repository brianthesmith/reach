class ServiceTagProvider
   def all_service_tags
      service_tags = []
      Player.all.each do |player|
         service_tags << player.service_tag
      end

      service_tags
   end
end
