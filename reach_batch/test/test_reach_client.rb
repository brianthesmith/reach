 require "app/reach_client"
 require "test/unit"
 
 class TestReachClient < Test::Unit::TestCase

  def test_get_game_history
     json = ReachClient.new.get_player_game_history(ReachConstants::BRIAN_LIVE_ID)

     assert(json.has_key? 'reason')

  end

  def test_get_game_details
    json = ReachClient.new.get_game_details '535592476'

    assert(json.has_key? 'GameDetails')

  end
 end