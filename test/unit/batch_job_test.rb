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
      # @test_object.execute
   end
end
