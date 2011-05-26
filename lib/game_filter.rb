class GameFilter
   def initialize(data_directory = "reach_data")
      @data_directory = data_directory
   end

   def filter_games()
      filtered_games = []
      Dir.glob("#{@data_directory}/*") do |file|
         file_contents = File.read(file)
         game_details = JSON.parse(file_contents)

         game = ReachGame.new
         game.id = game_details["GameDetails"]["GameId"]

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
