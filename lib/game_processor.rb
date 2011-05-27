require "kill_death_spread_processor"
require "player_effectiveness_processor"

class GameProcessor
   def initialize(game_processors = [KillDeathSpreadProcessor.new, PlayerEffectivenessProcessor.new])
      @game_processors = game_processors
   end

   def process_game(game)
      @game_processors.each do |processor|
         processor.process_game(game)
      end
   end
end
