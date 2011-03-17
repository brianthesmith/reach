require 'net/http'
#require 'json'
require 'reach_constants'
#require 'rubygems'

class ReachClient

	def get_player_game_history
	
		begin
			data = Net::HTTP.get_response(ReachConstants::GAME_HISTORY_ENDPOINT).body
		rescue
			print data
		end
	end
	
end