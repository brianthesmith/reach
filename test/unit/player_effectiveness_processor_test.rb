require "test_helper"

require "player_effectiveness_processor"

class PlayerEffectivenessProcessorTest < Test::Unit::TestCase
   def setup
      @test_object = PlayerEffectivenessProcessor.new(["player1", "player2", "player3"])

      PlayerEffectiveness.delete_all
   end

   def test_player_effectiveness_is_stored_in_db
      team1 = ReachTeam.new
      team1.id = "1"
      team1.score = "15"
      team2 = ReachTeam.new
      team2.id = "2"
      team2.score = "10"

      player1 = ReachPlayer.new
      player1.service_tag = "player1"
      player1.team_id = "1"
      player2 = ReachPlayer.new
      player2.service_tag = "player2"
      player2.team_id = "2"
      player3 = ReachPlayer.new
      player3.team_id = "1"
      player3.service_tag = "player3"

      map_name = random_string

      game = ReachGame.new
      game.map = map_name
      game.teams = [team1, team2]
      game.players = [player1, player2, player3]

      @test_object.process_game(game)

      assert_equal 3, PlayerEffectiveness.all.count

      player1_effectiveness = PlayerEffectiveness.where(:service_tag => "player1").first
      assert_equal map_name, player1_effectiveness.map
      assert_equal 15, player1_effectiveness.team_score
      assert_equal 2, player1_effectiveness.team_size
      assert_equal 10, player1_effectiveness.other_team_score
      assert_equal 1, player1_effectiveness.other_team_size

      player2_effectiveness = PlayerEffectiveness.where(:service_tag => "player2").first
      assert_equal map_name, player2_effectiveness.map
      assert_equal 10, player2_effectiveness.team_score
      assert_equal 1, player2_effectiveness.team_size
      assert_equal 15, player2_effectiveness.other_team_score
      assert_equal 2, player2_effectiveness.other_team_size

      player3_effectiveness = PlayerEffectiveness.where(:service_tag => "player3").first
      assert_equal map_name, player3_effectiveness.map   
      assert_equal 15, player3_effectiveness.team_score
      assert_equal 2, player3_effectiveness.team_size
      assert_equal 10, player3_effectiveness.other_team_score
      assert_equal 1, player3_effectiveness.other_team_size
   end
end
