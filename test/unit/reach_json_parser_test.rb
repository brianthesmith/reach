require "test_helper"

require "reach_json_parser"

class ReachJsonParserTest < Test::Unit::TestCase
   def setup
      @test_data_directory = "test_resources/reach_json_parser_data"

      @test_object = ReachJsonParser.new(@test_data_directory)

      Player.delete_all
      ReachMap.delete_all
      ReachTeam.delete_all
      ReachPlayerStat.delete_all
      ReachGame.delete_all
   end

   def test_populate_details
      player1 = Player.new
      player1.service_tag = "JM9C"
      player1.real_name = "Player 1"
      player1.save

      player2 = Player.new
      player2.service_tag = "HAMR"
      player2.real_name = "Player 2"
      player2.save

      player3 = Player.new
      player3.service_tag = "W707"
      player3.real_name = "Player 3"
      player3.save

      player4 = Player.new
      player4.service_tag = "MAC"
      player4.real_name = "Player 4"
      player4.save

      player5 = Player.new
      player5.service_tag = "X251"
      player5.real_name = "Player 5"
      player5.save

      player6 = Player.new
      player6.service_tag = "U525"
      player6.real_name = "Player 6"
      player6.save

      player7 = Player.new
      player7.service_tag = "O331"
      player7.real_name = "Player 7"
      player7.save

      ids = ["123", "456", "789"]

      @test_object.populate_details(ids)

      assert_equal 1, ReachMap.all.count
      assert_equal "Hemorrhage (Forge World)", ReachMap.all.first.name

      assert_equal 1, ReachGame.all.count
      saved_game = ReachGame.all.first
      assert_equal "789", saved_game.reach_id
      assert_equal "Assault", saved_game.name      
      assert_equal "Hemorrhage (Forge World)", saved_game.reach_map.name
      assert_equal 2, saved_game.reach_teams.size
      assert_equal 0, saved_game.reach_teams[0].team_id
      assert_equal 3, saved_game.reach_teams[0].reach_player_stats.count
      assert_equal 3, saved_game.reach_teams[0].score
      assert_equal 1, saved_game.reach_teams[1].team_id
      assert_equal 4, saved_game.reach_teams[1].reach_player_stats.count
      assert_equal 1, saved_game.reach_teams[1].score
   end
end
