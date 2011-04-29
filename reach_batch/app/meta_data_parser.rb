require "./app/weapon"

class MetaDataParser
   def initialize(meta_data_file_location = "resources/game_meta_data.txt")
      @meta_data = JSON.parse(File.new(meta_data_file_location).read)
   end

   def all_weapons
      @meta_data["Data"]["AllWeaponsById"].each do |json_weapon|
         weapon = Weapon.new

         weapon.name = json_weapon["Value"]["Name"]
         weapon.description = json_weapon["Value"]["Description"]

         weapon.save
      end
   end
end
