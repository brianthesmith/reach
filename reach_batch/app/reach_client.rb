require "rubygems"
require "json"
require "halo-reach-api"

class ReachClient
   ACCOUNT_1 ="Buckethead Died"
   ACCOUNT_2 = "jaymz9mm"
   CUSTOM_GAME = 6

   def initialize(reach = Halo::Reach::API.new(ApiKeyProvider.new))
      @reach = reach
   end

   def most_recent_games
      json_games = games_on_page(0)
      transform(json_games)
   end

   def all_historic_games
      json_games = []
      (0..24).each do |page|
         json_games = json_games | games_on_page(page)
      end

      games = transform(json_games)
      sort_by_id(games)
   end

   private
   def sort_by_id(games)
      games.sort do |game1, game2|
         game1.id <=> game2.id
      end
   end

   def transform(json_games)
      games = []
      json_games.each do |game_json|
         game = Game.new
         game.id = game_json["GameId"]
         games << game
      end
      games
   end

   def games_on_page(page_number)
      game_history1 = @reach.get_game_history(ACCOUNT_1, CUSTOM_GAME, page_number)["RecentGames"]
      game_history2 = @reach.get_game_history(ACCOUNT_2, CUSTOM_GAME, page_number)["RecentGames"]

      game_history1 | game_history2
   end

   class Game
      attr_accessor :id
   end
end
