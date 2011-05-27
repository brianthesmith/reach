class ReachClientTest < Test::Unit::TestCase
   def setup
      @test_data_directory = "test_resources/reach_client_data"
      FileUtils.rm_rf @test_data_directory
      FileUtils.mkdir @test_data_directory

      @reach_mock = mock()
      @test_object = ReachClient.new(@reach_mock, 0, @test_data_directory)
   end

   def teardown
      FileUtils.rm_rf @test_data_directory
      FileUtils.mkdir @test_data_directory
   end

   def test_unique_game_ids_are_returned_from_most_recent_games
      response1 = JSON.parse '{"RecentGames": [{"GameId": 123}, {"GameId": 456}]}'
      @reach_mock.stubs(:get_game_history).with(ReachClient::ACCOUNT_1, ReachClient::CUSTOM_GAME, 0).returns(response1)
      response2 = JSON.parse '{"RecentGames": [{"GameId": 123}, {"GameId": 789}]}'
      @reach_mock.stubs(:get_game_history).with(ReachClient::ACCOUNT_2, ReachClient::CUSTOM_GAME, 0).returns(response2)

      game_details = JSON.parse(File.new("test_resources/game_details.txt").read)
      details_response = mock
      details_response.stubs(:parsed_response).returns(game_details)
      @reach_mock.stubs(:get_game_details).with(any_parameters).returns(details_response)

      @test_object.most_recent_games

      assert_equal 3, Dir.glob("#{@test_data_directory}/*").count

      assert File::exists?("#{@test_data_directory}/123.json")
      assert File::exists?("#{@test_data_directory}/456.json")
      assert File::exists?("#{@test_data_directory}/789.json")
   end

   def test_all_historic_games_returns_games_with_ids
      generic_response = JSON.parse '{"RecentGames": [{"GameId": 1}]}'
      @reach_mock.stubs(:get_game_history).with(any_parameters).returns(generic_response)

      response1 = JSON.parse '{"RecentGames": [{"GameId": 2}]}'
      @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_1, ReachClient::CUSTOM_GAME, 0).returns(response1)
      response2 = JSON.parse '{"RecentGames": [{"GameId": 3}]}'
      @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_2, ReachClient::CUSTOM_GAME, 24).returns(response2)

      game_details = JSON.parse(File.new("test_resources/game_details.txt").read)
      details_response = mock
      details_response.stubs(:parsed_response).returns(game_details)
      @reach_mock.stubs(:get_game_details).with(any_parameters).returns(details_response)

      @test_object.all_historic_games

      assert_equal 3, Dir.glob("#{@test_data_directory}/*").count

      assert File::exists?("#{@test_data_directory}/1.json")
      assert File::exists?("#{@test_data_directory}/2.json")
      assert File::exists?("#{@test_data_directory}/3.json")
   end

   def test_all_historic_games_pulls_in_all_25_pages
      response = JSON.parse '{"RecentGames": [{"GameId": 1}]}'

      (0..24).each do |page_number|
         @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_1, ReachClient::CUSTOM_GAME, page_number).returns(response)
         @reach_mock.expects(:get_game_history).with(ReachClient::ACCOUNT_2, ReachClient::CUSTOM_GAME, page_number).returns(response)
      end

      game_details = JSON.parse(File.new("test_resources/game_details.txt").read)
      details_response = mock
      details_response.stubs(:parsed_response).returns(game_details)
      @reach_mock.stubs(:get_game_details).with(any_parameters).returns(details_response)

      @test_object.all_historic_games
   end

   def test_game_details
      game_id1 = random_string
      game_id2 = random_string

      response1 = JSON.parse '{"RecentGames": [{"GameId": "' + game_id1 + '"}]}'
      @reach_mock.stubs(:get_game_history).with(ReachClient::ACCOUNT_1, ReachClient::CUSTOM_GAME, 0).returns(response1)
      response2 = JSON.parse '{"RecentGames": [{"GameId": "' + game_id2 + '"}]}'
      @reach_mock.stubs(:get_game_history).with(ReachClient::ACCOUNT_2, ReachClient::CUSTOM_GAME, 0).returns(response2)

      game_details = JSON.parse(File.new("test_resources/game_details.txt").read)
      details_response = mock
      details_response.stubs(:parsed_response).returns(game_details)

      @reach_mock.stubs(:get_game_details).with(game_id1).returns(details_response)
      @reach_mock.stubs(:get_game_details).with(game_id2).returns(details_response)

      @test_object.most_recent_games
      
      contents1 = File.read("#{@test_data_directory}/#{game_id1}.json")
      contents2 = File.read("#{@test_data_directory}/#{game_id2}.json")

      assert game_details == JSON.parse(contents1)
      assert game_details == JSON.parse(contents2)
   end
end
