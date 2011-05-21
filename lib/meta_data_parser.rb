require "yaml"

require "./lib/weapon"
require "./lib/player"
require "./lib/reach_logging"

class MetaDataParser
   def initialize(player_file_location = "resources/players.txt", meta_data_file_location = "resources/game_meta_data.txt")
      @player_file_location = player_file_location
      @meta_data_file = File.new(meta_data_file_location)
   end

   def all_players
      LOG.info "removing all players"
      Player.delete_all

      LOG.info "loading all players"
      players = YAML.load_file(@player_file_location)

      LOG.info "number of players: #{players.length}"
      players.keys.each_with_index do |real_name, index|
         service_tag = players[real_name];
         player = Player.new
         player.id = index
         player.real_name = real_name
         player.service_tag = service_tag
         player.save
      end
   end

   def all_weapons
      LOG.info "removing all weapons"
      Weapon.delete_all

      LOG.info "loading all weapons"
      meta_data = JSON.parse(@meta_data_file.read)
      meta_data["Data"]["AllWeaponsById"].each do |json_weapon|
         weapon = Weapon.new

         weapon.id = json_weapon["Key"].to_i
         weapon.name = json_weapon["Value"]["Name"]
         weapon.description = json_weapon["Value"]["Description"]

         weapon.save
      end
   end
end
