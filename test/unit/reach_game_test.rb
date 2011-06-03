class ReachGameTest < Test::Unit::TestCase
   def setup
      ReachGame.delete_all
   end

   def test_retreive_by_reach_id
      reach_id = random_string
      now = Time.now.to_i

      game = ReachGame.new
      game.reach_id = reach_id
      game.timestamp = now
      game.save

      actual_game = ReachGame.find_by_reach_id(reach_id)

      assert_equal now, actual_game.timestamp.to_i
   end
end
