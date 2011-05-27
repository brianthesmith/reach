require "reach_json_parser"

class ReachJsonParserTest < Test::Unit::TestCase
   def setup
      @test_data_directory = "test_resources/reach_json_parser_data"

      @test_object = ReachJsonParser.new(@test_data_directory)
   end

   def test_populate_details
      game1 = ReachGame.new
      game1.id = "123"
      game2 = ReachGame.new
      game2.id = "456"
      game3 = ReachGame.new
      game3.id = "789"

      games = [game1, game2, game3]

      populated_games = @test_object.populate_details(games)

      assert_equal 1, populated_games.size
      assert_equal "789", populated_games[0].id
      assert_equal 2, populated_games[0].teams.size
   end
end
