require "test/unit"
require "json"
require "mocha"

require "reach_client"

class ReachClientTest < Test::Unit::TestCase
   def setup
      @reach_mock = mock()

      @test_object = ReachClient.new(@reach_mock, 0)
   end

   def test_unique_game_ids_are_returned_from_most_recent_games
      response1 = JSON.parse '{"RecentGames": [{"GameId": 123}, {"GameId": 456}]}'
      @reach_mock.stubs(:get_game_history).with(ReachClient::ACCOUNT_1, ReachClient::CUSTOM_GAME, 0).returns(response1)
      response2 = JSON.parse '{"RecentGames": [{"GameId": 123}, {"GameId": 789}]}'
      @reach_mock.stubs(:get_game_history).with(ReachClient::ACCOUNT_2, ReachClient::CUSTOM_GAME, 0).returns(response2)

      games = @test_object.most_recent_games

      assert_equal 3, games.size
      assert_equal 123, games[0].id
      assert_equal 456, games[1].id
      assert_equal 789, games[2].id
   end

   def test_all_historic_games_returns_games_with_ids
      generic_response = JSON.parse '{"RecentGames": [{"GameId": 1}]}'
      @reach_mock.stubs(:get_game_history).with(any_parameters).returns(generic_response)

      response1 = JSON.parse '{"RecentGames": [{"GameId": 2}]}'
      @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_1, ReachClient::CUSTOM_GAME, 0).returns(response1)
      response2 = JSON.parse '{"RecentGames": [{"GameId": 3}]}'
      @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_2, ReachClient::CUSTOM_GAME, 24).returns(response2)

      games = @test_object.all_historic_games

      assert_equal 3, games.size
      assert_equal 1, games[0].id
      assert_equal 2, games[1].id
      assert_equal 3, games[2].id
   end

   def test_all_historic_games_pulls_in_all_25_pages
      response = JSON.parse '{"RecentGames": [{"GameId": 1}]}'

      (0..24).each do |page_number|
         @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_1, ReachClient::CUSTOM_GAME, page_number).returns(response)
         @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_2, ReachClient::CUSTOM_GAME, page_number).returns(response)
      end

      @test_object.all_historic_games
   end

   def test_game_details
      game_details = JSON.parse(File.new("test_resources/game_details.txt").read)

      game_id = random_string

      @reach_mock.expects(:get_game_details).with(game_id).returns(game_details)

      games = [ReachGame.new]
      games[0].id = game_id

      @test_object.populate_details(games)
   end
end
