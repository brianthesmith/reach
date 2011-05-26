require "rubygems"
require "json"
require "halo-reach-api"
require "active_record"

require "reach_game"
require "reach_player"
require "reach_team"
require "reach_weapon_carnage_report"

class ReachClient
   ACCOUNT_1 ="Buckethead Died"
   ACCOUNT_2 = "jaymz9mm"
   CUSTOM_GAME = 6

   def initialize(reach = Halo::Reach::API.new(ApiKeyProvider.new.api_key), throttle = 0.5, output_directory = "reach_data")
      @reach = reach
      @throttle = throttle
      @output_directory = output_directory
   end

   def most_recent_games
      json_games = games_on_page(0)
      ids = get_game_ids(json_games)
      retreive_game_details(ids)
   end

   def all_historic_games
      json_games = []
      (0..24).each do |page|
         json_games = json_games | games_on_page(page)
      end

      ids = get_game_ids(json_games)
      retreive_game_details(ids)
   end

   private
   def retreive_game_details(ids)
      total_games = ids.length
      current_game = 0
      ids.each do |id|
         sleep(@throttle)
         current_game += 1
         LOG.info " - downloading #{current_game} out of #{total_games}"
         game_details_json = @reach.get_game_details(id)

         write_out_details(id, game_details_json)
      end
   end

   def write_out_details(id, game_details_json)
      json_text = JSON.generate(game_details_json)

      output_file = File.new("#{@output_directory}/#{id}.json", "w+")
      output_file.write(json_text)
      output_file.close
   end

   def get_game_ids(json_games)
      ids = []
      json_games.each do |game_json|
         ids <<  game_json["GameId"]
      end

      ids.sort!
   end

   def games_on_page(page_number)
      game_history1 = @reach.get_game_history(ACCOUNT_1, CUSTOM_GAME, page_number)["RecentGames"]
      game_history2 = @reach.get_game_history(ACCOUNT_2, CUSTOM_GAME, page_number)["RecentGames"]

      game_history1 | game_history2
   end
end
