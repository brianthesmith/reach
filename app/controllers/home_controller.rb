class HomeController < ActionController::Base
   layout "application"

   def index
      @title = "Home"
   end
end
