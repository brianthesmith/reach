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

      game_id1 = random_string
      game_id2 = random_string

      ids = [game_id1, game_id2]

      @game_filter.expects(:filter_game_ids).returns(ids)

      @reach_json_parser.expects(:populate_details).with(ids)

      @game_processor.expects(:process_game).with(game_id1)
      @game_processor.expects(:process_game).with(game_id2)

      @test_object.execute
   end
end
