require "reach_client"
require "game_filter"
require "statistics_extracter"
require "api_key_provider"
require "active_record"
require "meta_data_parser"
require "service_tag_provider"

class BatchJob
   def initialize(meta_data_parser = MetaDataParser.new, reach_client = ReachClient.new, game_filter = GameFilter.new, game_processor = GameProcessor.new)
      @meta_data_parser = meta_data_parser
      @reach_client = reach_client
      @game_filter = game_filter
      @game_processor = game_processor
   end

   def execute
      populate_meta_data

      LOG.info "Running batch job..."
      fetch_game_data.each do |game|
         LOG.info " - processing game: #{game.id}"

         @game_processor.process_game(game)         
      end
      LOG.info "Running batch job: complete."
   end

   private
   def populate_meta_data
      LOG.info "Populating meta-data..."
      if Weapon.all.empty?
         @meta_data_parser.all_weapons
      end

      if Player.all.empty?
         @meta_data_parser.all_players
      end
      LOG.info "Populating meta-data: complete."
   end

   def fetch_game_data
      all_games = @reach_client.all_historic_games

      LOG.info " - retrieved #{all_games.length} game(s)"
      filtered_games = @game_filter.filter_games(all_games)
      LOG.info " - filtered games: #{filtered_games.length} game(s) remaining to be imported"

      game_details = @reach_client.populate_details(filtered_games)
   end
end
