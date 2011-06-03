require "game_processor"

class GameProcessorTest < Test::Unit::TestCase
   def setup
      @processor1 = StubProcessor.new
      @processor2 = StubProcessor.new

      @test_object = GameProcessor.new([@processor1, @processor2])

      ReachGame.delete_all
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

   def test_games_that_arent_in_the_db_dont_get_processed
      @test_object.process_game(random_string)

      assert_nil @processor1.given_id
      assert_nil @processor2.given_id
   end
end

class StubProcessor
   attr_accessor :given_id

   def process_game(game)
      @given_id = game.reach_id
   end
end
