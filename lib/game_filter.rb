class GameFilter
   def filter_games(games)
      filtered_games = []
      games.each do |game|
         if is_game_unique?(game)
            filtered_games << game
         end
      end

      filtered_games
   end

   private
   def is_game_unique?(game)
      PlayerStatistic.where("reach_game_id = ?", game.id).length == 0
   end
end
