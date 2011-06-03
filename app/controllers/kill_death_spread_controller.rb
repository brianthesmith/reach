class KillDeathSpreadController < ActionController::Base
   layout "application"

   def index
      @title = "Average Kill/Death Spread"

      @player_stats = KillDeathSpreadModel.average_stats
   end
end
