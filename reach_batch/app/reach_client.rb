require 'rubygems'
require 'net/http'
require 'json'
require 'app/reach_url_builder'

class ReachClient

  def initialize
    @urlBuilder = ReachURLBuilder.new("resources/api_key.txt")
  end

	def get_player_game_history(player)
      JSON.parse(Net::HTTP.get_response(URI.parse(@urlBuilder.game_history_endpoint(player,"0"))).body)
  end

  def get_game_details(gameId)
      JSON.parse(Net::HTTP.get_response(URI.parse(@urlBuilder.game_details_endpoint(gameId))).body)
  end
  
end