class ReachConstants

  	api_key = "Sb4XYTPLuGLR8ZZhXyitTpseX0DbqfUTnzsmeyzWzfU="
		base_url = "http://www.bungie.net/api/reach/reachapijson.svc"
		PLAYER = "Buckethead%20Died"
		GAME_HISTORY_ENDPOINT = URI.parse(base_url + '/player/gamehistory/' + api_key + '/' + ReachConstants::PLAYER + '/6/0')

end
