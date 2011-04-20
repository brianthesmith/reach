require "test/unit"
require "app/reach_client"

class ReachClientTest < Test::Unit::TestCase
   def test_something
      puts ReachClient.new.pull_data
   end
end
