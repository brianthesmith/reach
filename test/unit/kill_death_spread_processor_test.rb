require "kill_death_spread_processor"

class KillDeathSpreadProcessorTest < Test::Unit::TestCase
   def setup
      @test_object = KillDeathSpreadProcessor.new(["player1", "player2"])

      ReachPlayerStat.delete_all      
      ReachTeam.delete_all      
      ReachGame.delete_all
      KillDeathSpread.delete_all
   end

   def test_kill_death_spread_processor
      reach_id = random_string

      player1 = Player.new
      player1.service_tag = "player1"
      player1.save

      player2 = Player.new
      player2.service_tag = "player2"
      player2.save

      game = ReachGame.new
      game.reach_id = reach_id
      game.save

      team1 = ReachTeam.new
      game.reach_teams << team1

      team2 = ReachTeam.new
      game.reach_teams << team2

      player1_stat = ReachPlayerStat.new
      player1_stat.player = player1
      player1_stat.kills = 6
      player1_stat.deaths = 8
      team1.reach_player_stats << player1_stat

      player2_stat = ReachPlayerStat.new
      player2_stat.player = player2
      player2_stat.kills = 10
      player2_stat.deaths = 4
      team2.reach_player_stats << player2_stat

      @test_object.process_game(game)

      assert_equal 2, KillDeathSpread.all.count

      player1_spread = KillDeathSpread.find_by_service_tag("player1").first
      assert_equal 6, player1_spread.kills
      assert_equal 8, player1_spread.deaths
      assert_equal -2, player1_spread.spread

      player2_spread = KillDeathSpread.find_by_service_tag("player2").first
      assert_equal 10, player2_spread.kills
      assert_equal 4, player2_spread.deaths
      assert_equal 6, player2_spread.spread
   end
end
