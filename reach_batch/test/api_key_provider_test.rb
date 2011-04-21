require 'test/unit'
require 'app/api_key_provider'

class ApiKeyProviderTest <  Test::Unit::TestCase
   def setup
      @test_object = ApiKeyProvider.new('test_resources/test_api_key.txt')
   end

   def test_api_key_returns_with_key_from_specified_location
      assert_equal "TestApiKeyValue", @test_object.api_key
   end
end
