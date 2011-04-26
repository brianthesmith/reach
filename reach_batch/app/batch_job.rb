require "reach_client"
require "api_key_provider"

puts "Running batch job..."
client = ReachClient.new

puts "latest games: "
client.all_historic_games.each do |game|
   puts "#{game.id}"
end
