require "game_processor"

class GameProcessorTest < Test::Unit::TestCase
   def setup
      @processor1 = StubProcessor.new
      @processor2 = StubProcessor.new

      @test_object = GameProcessor.new([@processor1, @processor2])
   end

   def test_each_processor_is_called_with_the_given_game
      id = random_string

      game = ReachGame.new
      game.id = id
      @test_object.process_game(game)

      assert_equal id, @processor1.given_id
      assert_equal id, @processor2.given_id
   end
end

class StubProcessor
   attr_accessor :given_id

   def process_game(game)
      @given_id = game.id
   end
end
