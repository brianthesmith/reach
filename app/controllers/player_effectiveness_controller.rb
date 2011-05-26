class PlayerEffectivenessController < ActionController::Base
   layout "application"

   def index
      @title = "Player Effectiveness"
      @player_stats = PlayerEffectivenessModel.stats_for_all_maps
   end
end
