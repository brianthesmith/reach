require "kill_death_spread_processor"

class KillDeathSpreadProcessorTest < Test::Unit::TestCase
   def setup
      @test_object = KillDeathSpreadProcessor.new

      KillDeathSpread.delete_all
   end

   def test_this
      player1 = ReachPlayer.new
      player1.service_tag = "player1"
      player1.kills = 6
      player1.deaths = 8

      player2 = ReachPlayer.new
      player2.service_tag = "player2"
      player2.kills = 10
      player2.deaths = 4

      game = ReachGame.new

      game.players = [player1, player2]

      @test_object.process_game(game)

      assert_equal 2, KillDeathSpread.all.count

      player1_spread = KillDeathSpread.where(:service_tag => "player1").first
      assert_equal 6, player1_spread.kills
      assert_equal 8, player1_spread.deaths
      assert_equal -2, player1_spread.spread

      player2_spread = KillDeathSpread.where(:service_tag => "player2").first
      assert_equal 10, player2_spread.kills
      assert_equal 4, player2_spread.deaths
      assert_equal 6, player2_spread.spread
   end
end
