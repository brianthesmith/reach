 require "app/reach_url_builder"
 require "test/unit"
 
 class TestReachClient < Test::Unit::TestCase

  def test_api_key
     testObject = ReachURLBuilder.new("test_resources/test_api_key.txt")
     assert_equal("TestValue",testObject.api_key)
  end

 end