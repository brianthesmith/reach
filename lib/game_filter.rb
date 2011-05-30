class GameFilter
   def initialize(data_directory = "reach_data")
      @data_directory = data_directory
   end

   def filtered_game_ids
      filtered_game_ids = []
      Dir.glob("#{@data_directory}/*") do |file|
         file_contents = File.read(file)
         file_contents = JSON.parse(file_contents)

         reach_id = file_contents["GameDetails"]["GameId"]

         if is_game_unique?(reach_id)
            filtered_game_ids << reach_id
         end
      end

      filtered_game_ids
   end

   private
   def is_game_unique?(reach_id)
      ReachGame.find_by_reach_id(reach_id) == nil
   end
end
