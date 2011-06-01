class GameHistoryController < ActionController::Base
   layout "application"

   def index
      @title = "Game History"

      @games = ReachGame.find(:all, :order => "timestamp DESC")
   end
end
