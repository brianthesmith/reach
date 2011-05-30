require "game_processor"

class GameProcessorTest < Test::Unit::TestCase
   def setup
      @processor1 = StubProcessor.new
      @processor2 = StubProcessor.new

      @test_object = GameProcessor.new([@processor1, @processor2])
   end

   def test_each_processor_is_called_with_the_given_game
      reach_id = random_string

      game = ReachGame.new
      game.reach_id = reach_id
      game.save

      @test_object.process_game(reach_id)

      assert_equal reach_id, @processor1.given_id
      assert_equal reach_id, @processor2.given_id
   end
end

class StubProcessor
   attr_accessor :given_id

   def process_game(game_id)
      @given_id = game_id
   end
end
