require 'yaml'

class ReachURLBuilder

		BRIAN_LIVE_ID = "Buckethead%20Died"
    JAMES_LIVE_ID = "jaymz9mm"

    def initialize(api_key)
       @api_key_file = api_key
       @base_url = "http://www.bungie.net/api/reach/reachapijson.svc"
    end
   
    def game_history_endpoint(player, page)
      @base_url << "/player/gamehistory/" << api_key << "/" << player << "/6/" << page
    end

    def game_details_endpoint(gameId)
      @base_url << "/game/details/" << api_key  << "/" << gameId
    end
  
    def api_key
      file = File.new(@api_key_file)
      api_key = file.gets
      file.close
      return api_key
    end

end
