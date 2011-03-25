require 'rubygems'
require 'net/http'
require 'json'
require 'app/reach_constants'

class ReachClient

	def get_player_game_history
    
      JSON.parse(Net::HTTP.get_response(URI.parse(ReachConstants.new(ReachConstants::API_KEY).game_history_endpoint)).body)
  end

  def get_game_details(gameId)
      JSON.parse(Net::HTTP.get_response(URI.parse(ReachConstants.new(ReachConstants::API_KEY).game_details_endpoint + gameId)).body)
  end
	
end