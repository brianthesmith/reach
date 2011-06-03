require "kill_death_spread_processor"
require "player_effectiveness_processor"

class GameProcessor
   def initialize(game_processors = [KillDeathSpreadProcessor.new, PlayerEffectivenessProcessor.new])
      @game_processors = game_processors
   end

   def process_game(reach_game_id)
      game = ReachGame.find_by_reach_id(reach_game_id)
      if game != nil
         @game_processors.each do |processor|
            processor.process_game(game)
         end
      end
   end
end
