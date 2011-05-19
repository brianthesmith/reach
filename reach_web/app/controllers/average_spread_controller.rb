class AverageSpreadController < ActionController::Base
   layout "application"

   def index
      @player_stats = AverageSpreadModel.average_spread

      @title = "Average Kill/Death Spread"
      @stat_type = "Kill/Death Spread"
   end
end
