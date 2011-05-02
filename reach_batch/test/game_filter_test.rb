require "test/unit"

require "player_statistic"
require "random_game_id"
require "test_connection_info"
require "game_filter"

class GameFilterTest < Test::Unit::TestCase
   def setup
      @test_object = GameFilter.new

      PlayerStatistic.delete_all
   end

   def test_games_in_db_are_filtered_out
      game1 = ReachGame.new
      game1.id = random_game_id
      game2 = ReachGame.new
      game2.id = random_game_id
      game3 = ReachGame.new
      game3.id = random_game_id
      game4 = ReachGame.new
      game4.id = random_game_id

      player_stat1 = PlayerStatistic.new
      player_stat1.reach_game_id = game1.id
      player_stat1.save

      player_stat2 = PlayerStatistic.new
      player_stat2.reach_game_id = game3.id
      player_stat2.save

      filtered_games = @test_object.filter_games([game1, game2, game3, game4])

      assert_equal(2, filtered_games.length)
      assert_equal(game2.id, filtered_games[0].id)
      assert_equal(game4.id, filtered_games[1].id)
   end
end
