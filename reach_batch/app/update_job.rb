require "reach_client"
require "api_key_provider"

puts "Running update job..."

puts "latest games: "
ReachClient.new.most_recent_games.each do |game|
   puts "#{game.id}"
end
