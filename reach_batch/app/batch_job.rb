require "reach_client"
require "api_key_provider"
require "initialize_db"
require "active_record"

puts "Running batch job..."


puts "latest games: "
all_games = ReachClient.new.all_historic_game_ids
all_game_details = ReachClient.new.populate_details(all_games)
statistics_extracter = StatisticsExtracter.new
all_game_details.each do |game|
   all_player_statistics = statistics_extracter.extract_statistics(game)
   all_player_statistics.each do |player_statistics|
      player_statistics.save
   end
end


puts "Running batch job: complete."
