require "test_helper"

require "game_filter"

class GameFilterTest < Test::Unit::TestCase
   def setup
      @test_object = GameFilter.new("test_resources/game_filter_data")

      PlayerStatistic.delete_all
   end

   def test_games_in_db_are_filtered_out
      player_stat1 = PlayerStatistic.new
      player_stat1.reach_game_id = "1234567890"
      player_stat1.save

      player_stat2 = PlayerStatistic.new
      player_stat2.reach_game_id = "3456789012"
      player_stat2.save

      filtered_games = @test_object.filter_games
      
      assert_equal 2, filtered_games.length
      assert_equal 2345678901, filtered_games[0].id
      assert_equal 4567890123, filtered_games[1].id
   end
end
