require "test_helper"

require "batch_job"

class BatchJobTest < Test::Unit::TestCase
   def setup
      @meta_data_parser = mock
      @reach_client = mock
      @game_filter = mock
      @statistics_extracter = mock

      @test_object = BatchJob.new(@meta_data_parser, @reach_client, @game_filter, @statistics_extracter)
   end

   def test_execute
      # @meta_data_parser.expects(:all_weapons)
      # @meta_data_parser.expects(:all_players)

      # games = []
      # @reach_client.exepects(:all_historic_games).returns(games)

      # @test_object.execute
   end
end
