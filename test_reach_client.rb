 require "reach_client"
 require "test/unit"
 
 class TestReachClient < Test::Unit::TestCase
 
  def test_get_game_history
     json = ReachClient.new.get_player_game_history

     assert(json.has_key? 'reason')

  end

  def test_get_game_details
    json = ReachClient.new.get_game_details '523742668'

    assert(json.has_key? 'GameDetails')
  end
 
 end