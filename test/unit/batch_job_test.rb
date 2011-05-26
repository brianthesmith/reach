require "test_helper"

require "batch_job"

class BatchJobTest < Test::Unit::TestCase
   def setup
      @meta_data_parser = mock
      @reach_client = mock
      @reach_json_parser = mock      
      @game_filter = mock
      @game_processor = mock

      @test_object = BatchJob.new(@meta_data_parser, @reach_client, @reach_json_parser, @game_filter, @game_processor)

      Weapon.delete_all
      Player.delete_all
   end

   def test_execute
      @meta_data_parser.expects(:all_weapons)
      @meta_data_parser.expects(:all_players)

      @reach_client.expects(:all_historic_games)
      
      game1 = ReachGame.new
      game1.id = random_string
      game2 = ReachGame.new
      game2.id = random_string

      games = [game1, game2]
      @game_filter.expects(:filter_games).returns(games)

      game_details1 = ReachGame.new
      game_details1.id = random_string
      game_details2 = ReachGame.new
      game_details2.id = random_string

      game_details = [game_details1, game_details2]

      @reach_json_parser.expects(:populate_details).with(games).returns(game_details)

      @game_processor.expects(:process_game).with(game_details1)
      @game_processor.expects(:process_game).with(game_details2)

      @test_object.execute
   end
end
