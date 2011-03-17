 require "reach_client"
 require "test/unit"
 
 class TestReachClient < Test::Unit::TestCase
 
  def test_get_game_history
     json = ReachClient.new.get_player_game_history
   end
 
 end