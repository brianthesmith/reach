require "reach_client"
require "game_filter"
require "statistics_extracter"
require "api_key_provider"
require "active_record"
require "meta_data_parser"
require "service_tag_provider"

class BatchJob
   def initialize(meta_data_parser = MetaDataParser.new, reach_client = ReachClient.new, reach_json_parser = ReachJsonParser.new, game_filter = GameFilter.new, game_processor = GameProcessor.new)
      @meta_data_parser = meta_data_parser
      @reach_client = reach_client
      @reach_json_parser = reach_json_parser
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
      @reach_client.all_historic_games

      filtered_games = @game_filter.filter_games
      LOG.info " - #{filtered_games.length} game(s) to be imported into the database"

      @reach_json_parser.populate_details(filtered_games)
   end
end
