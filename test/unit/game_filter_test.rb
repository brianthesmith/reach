require "test_helper"

require "game_filter"

class GameFilterTest < Test::Unit::TestCase
   def setup
      @test_object = GameFilter.new("test_resources/game_filter_data")

      ReachGame.delete_all
   end

   def test_games_in_db_are_filtered_out
      game1 = ReachGame.new
      game1.reach_id = "1234567890"
      game1.save

      game2 = ReachGame.new
      game2.reach_id = "3456789012"
      game2.save

      filtered_game_ids = @test_object.filtered_game_ids
      
      assert_equal 2, filtered_game_ids.length
      assert_equal 2345678901, filtered_game_ids[0]
      assert_equal 4567890123, filtered_game_ids[1]
   end
end
