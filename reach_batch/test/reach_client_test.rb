require "test/unit"
require "app/reach_client"
require "json"
require "mocha"

class ReachClientTest < Test::Unit::TestCase
   class ReachStub
      attr_accessor :account
      attr_accessor :type
      attr_accessor :page
      attr_accessor :return_content

      def get_game_history(account, type, page)
         @account = account
         @type = type
         @page = page
         @return_content
      end
   end

   def setup
      @reach_mock = Halo::Reach::API.new(nil)

      @test_object = ReachClient.new(@reach_mock)
   end

   def test_game_ids_are_populated_in_returned_recent_games
      response1 = JSON.parse '{"RecentGames": [{"GameId": 123}, {"GameId": 456}]}'
      @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_1, 6, 0).returns(response1)
      response2 = JSON.parse '{"RecentGames": [{"GameId": 123}, {"GameId": 789}]}'
      @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_2, 6, 0).returns(response2)

      games = @test_object.game_history

      assert_equal 3, games.size      
      assert_equal 123, games[0].id
      assert_equal 456, games[1].id
      assert_equal 789, games[2].id
   end
end
