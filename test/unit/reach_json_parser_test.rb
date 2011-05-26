require "test/unit"
require "json"
require "mocha"

require "reach_client"

class ReachJsonParserTest < Test::Unit::TestCase
   def setup
      @test_data_directory = "test_resources/reach_json_parser_data"

      @test_object = ReachJsonParser.new(@test_data_directory)
   end

   def test_populate_details
      game1 = ReachGame.new
      game1.id = "1"
      game2 = ReachGame.new
      game2.id = "2"
      game3 = ReachGame.new
      game3.id = "3"

      games = [game1, game2, game3]

      populated_games = @test_object.populate_details(games)

      assert_equal 3, games.size
      assert_equal 123, games[0].id
      assert_equal 456, games[1].id
      assert_equal 789, games[2].id
   end
end
