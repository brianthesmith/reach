require 'rubygems'
require 'json'
require 'halo-reach-api'

class ReachClient
   ACCOUNT_1 ="Buckethead Died"
   ACCOUNT_2 = "jaymz9mm"
   CUSTOM_GAME = 6

   def initialize(reach = Halo::Reach::API.new(ApiKeyProvider.new))
      @reach = reach
   end

   def game_history
      game_history_json = @reach.get_game_history(ACCOUNT_1, 6, 0)

      games = []
      game_history_json['RecentGames'].each do |game_json|
         game = Game.new
         game.id = game_json['GameId']
         games << game
      end

      return games
   end

   class Game
      attr_accessor :id
   end
end
