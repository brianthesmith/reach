class BaseProcessor
   def initialize(known_service_tags)
      @known_service_tags = known_service_tags
   end

   def is_known_player?(questionable_service_tag)
      is_valid = false
      @known_service_tags.each do |good_service_tag|
         if questionable_service_tag == good_service_tag
            is_valid = true
            break
         end
      end

      is_valid
   end
end
