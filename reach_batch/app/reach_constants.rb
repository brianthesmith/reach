require 'yaml'

class ReachConstants

  	API_KEY = "Sb4XYTPLuGLR8ZZhXyitTpseX0DbqfUTnzsmeyzWzfU="
		BRIAN_LIVE_ID = "Buckethead%20Died"
    JAMES_LIVE_ID = "jaymz9mm"

    def initialize(api_key)
      @api_key = api_key
		@base_url = "http://www.bungie.net/api/reach/reachapijson.svc"
   end
   
#   def api_key
#     @api_key
#   end

    def game_history_endpoint(player)
      prefix = base_url + "/player/gamehistory/"
      suffix = "/6/0"
      return prefix + @api_key + "/" + player + suffix
    end

    def game_details_endpoint
      return @base_url + "/game/details/" + @api_key  + "/"
    end

end
