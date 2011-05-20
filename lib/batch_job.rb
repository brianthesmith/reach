require "reach_client"
require "game_filter"
require "statistics_extracter"
require "api_key_provider"
require "active_record"
require "prod_connection_info"
require "meta_data_parser"
require "service_tag_provider"

LOG.info "Populating meta-data..."

meta_data_parser = MetaDataParser.new

if Weapon.all.empty?
   meta_data_parser.all_weapons
end

if Player.all.empty?
   meta_data_parser.all_players
end

LOG.info "Populating meta-data: complete."

LOG.info "Running batch job..."

all_games = ReachClient.new.all_historic_games

LOG.info " - retrieved #{all_games.length} game(s)"
filtered_games = GameFilter.new.filter_games(all_games)

LOG.info " - filtered games: #{filtered_games.length} game(s) remaining to be imported"
game_details = ReachClient.new.populate_details(filtered_games)
statistics_extracter = StatisticsExtracter.new(ServiceTagProvider.new.all_service_tags)

game_details.each do |game|
   LOG.info " - processing game: #{game.id}"

   begin
      all_player_statistics = statistics_extracter.extract_statistics(game)

      LOG.info "number of stats created for game: #{all_player_statistics.length}"
      all_player_statistics.each do |player_statistics|
         player_statistics.save
      end
   rescue Exception => e
      LOG.info " - error processing game: #{e.message}"
   end
end

LOG.info "Running batch job: complete."
