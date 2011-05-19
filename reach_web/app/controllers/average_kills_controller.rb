class AverageKillsController < ActionController::Base
   layout "application"

   def index
      @player_stats = AverageKillsModel.average_kills

      @title = "Average Kills"
      @stat_type = "Kills"
   end
end
