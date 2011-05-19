class AverageDeathsController < ActionController::Base
   layout "application"

   def index
      @player_stats = AverageDeathsModel.average_deaths

      @title = "Average Deaths"
      @stat_type = "Deaths"
   end
end
