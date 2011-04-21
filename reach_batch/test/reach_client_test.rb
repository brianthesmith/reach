require "test/unit"
require "app/reach_client"
require "json"

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
      @reach_mock = ReachStub.new

      @test_object = ReachClient.new(@reach_mock)
   end

   def test_game_ids_are_populated_in_returned_recent_games
      @reach_mock.return_content = JSON.parse '{"RecentGames": [{"GameId": 123}, {"GameId": 456}]}'

      games = @test_object.game_history

      assert_equal 2, games.size      
      assert_equal 123, games[0].id
      assert_equal 456, games[1].id
   end
end
