require "player"

class ServiceTagProviderTest < Test::Unit::TestCase
   def setup
      @test_object = ServiceTagProvider.new

      Player.delete_all
   end

   def test_all_service_tags
      service_tag1 = random_string
      service_tag2 = random_string
      service_tag3 = random_string

      player1 = Player.new
      player1.service_tag = service_tag1
      player1.save

      player2 = Player.new
      player2.service_tag = service_tag2
      player2.save

      player3 = Player.new
      player3.service_tag = service_tag3
      player3.save

      service_tags = @test_object.all_service_tags

      assert_equal(3, service_tags.length)
      assert(service_tags.include?(service_tag1))
      assert(service_tags.include?(service_tag2))
      assert(service_tags.include?(service_tag3))
   end
end
