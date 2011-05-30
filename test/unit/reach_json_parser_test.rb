require "reach_json_parser"

class ReachJsonParserTest < Test::Unit::TestCase
   def setup
      @test_data_directory = "test_resources/reach_json_parser_data"

      @test_object = ReachJsonParser.new(@test_data_directory)

      ReachTeam.delete_all
      ReachPlayer.delete_all
      ReachGame.delete_all
   end

   def test_populate_details
      ids = ["123", "456", "789"]

      @test_object.populate_details(ids)

      assert_equal 1, ReachGame.all.count

      game = ReachGame.all.first
      assert_equal "789", game.reach_id
      assert_equal "Hemorrhage (Forge World)", game.map.name
      assert_equal 2, game.teams.size

   end
end
