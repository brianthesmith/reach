require "./app/weapon"
require "./app/player"
require "yaml"

class MetaDataParser
   def initialize(player_file_location = "resources/players.txt", meta_data_file_location = "resources/game_meta_data.txt")
      @player_file_location = player_file_location
      @meta_data_file = File.new(meta_data_file_location)
   end

   def all_players
      players = YAML.load_file(@player_file_location)
      players.keys.each do |real_name|
         service_tag = players[real_name];
         player = Player.new
         player.real_name = real_name
         player.service_tag = service_tag
         player.save
      end
   end

   def all_weapons
      meta_data = JSON.parse(@meta_data_file.read)
      meta_data["Data"]["AllWeaponsById"].each do |json_weapon|
         weapon = Weapon.new

         weapon.name = json_weapon["Value"]["Name"]
         weapon.description = json_weapon["Value"]["Description"]

         weapon.save
      end
   end
end
