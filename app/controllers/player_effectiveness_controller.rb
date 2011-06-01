class PlayerEffectivenessController < ActionController::Base
   layout "application"

   def index
      @title = "Player Effectiveness"
      @maps = ReachMap.find(:all, :order => "name")
   end

   def show
      @title = "Player Effectiveness"

      map_name = params[:map_name]

      @player_stats = PlayerEffectivenessModel.stats_for_map(map_name)
   end
end
