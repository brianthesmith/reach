require 'rubygems'
require 'net/http'
require 'json'
require 'reach_constants'

class ReachClient

	def get_player_game_history
	
		begin
			data = Net::HTTP.get_response(URI.parse(ReachConstants::GAME_HISTORY_ENDPOINT)).body

      json = JSON.parse(data)

		rescue
			print data
		end
  end

  def get_game_details(gameId)
    begin
      data = Net::HTTP.get_response(URI.parse(ReachConstants::GAME_DETAILS_ENDPOINT + gameId)).body

      json = JSON.parse(data)
  	rescue
			print data
		end
  end
	
end