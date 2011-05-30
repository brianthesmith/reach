class PlayerTest < Test::Unit::TestCase
   def setup
      Player.delete_all
   end

   def test_finding_players_by_service_tag
      player1_real_name = random_string
      player1_service_tag = random_string

      player2_real_name = random_string
      player2_service_tag = random_string

      player1 = Player.new
      player1.service_tag = player1_service_tag
      player1.real_name = player1_real_name
      player1.save

      player2 = Player.new
      player2.service_tag = player2_service_tag
      player2.real_name = player2_real_name
      player2.save

      assert_equal player1_real_name, Player.find_by_service_tag(player1_service_tag).real_name
      assert_equal player2_real_name, Player.find_by_service_tag(player2_service_tag).real_name
   end
end
