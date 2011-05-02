require "reach_client"
require "game_filter"
require "statistics_extracter"
require "api_key_provider"
require "active_record"
require "prod_connection_info"
require "meta_data_parser"
require "service_tag_provider"

puts "Populating meta-data..."

meta_data_parser = MetaDataParser.new

if Weapon.all.length != 0
   meta_data_parser.all_weapons
end

if Player.all.length != 0
   meta_data_parser.all_players
end

puts "Populating meta-data: complete."

puts "Running batch job..."

all_games = ReachClient.new.all_historic_games
filtered_games = GameFilter.new.filter_games(all_games)
game_details = ReachClient.new.populate_details(filtered_games)
statistics_extracter = StatisticsExtracter.new(ServiceTagProvider.new.all_service_tags)
game_details.each do |game|
   all_player_statistics = statistics_extracter.extract_statistics(game)
   all_player_statistics.each do |player_statistics|
      player_statistics.save
   end
end

puts "Running batch job: complete."
