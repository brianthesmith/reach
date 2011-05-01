require "test/unit"
require "json"
require "mocha"

require "meta_data_parser"
require "test_connection_info"

class MetaDataParserTest < Test::Unit::TestCase
   def setup
      player_list_file = "test_resources/test_player_list.txt"
      meta_data_file = "test_resources/test_game_meta_data.txt"
      @test_object = MetaDataParser.new(player_list_file, meta_data_file)

      Weapon.delete_all
      Player.delete_all
   end

   def test_all_weapons_are_pulled_from_file
      @test_object.all_weapons

      assert_equal(3, Weapon.all.length)
      assert_equal("Weapon one", Weapon.all.first.name)
      assert_equal("This is the first weapon", Weapon.all.first.description)
      assert_equal("Weapon three", Weapon.all.last.name)
      assert_equal("This is the third weapon", Weapon.all.last.description)
   end

   def test_all_players_are_pulled_in_from_file
      @test_object.all_players

      assert_equal(2, Player.all.length)
      assert_equal("player 1", Player.all.first.real_name)
      assert_equal("service tag 1", Player.all.first.service_tag)
      assert_equal("player 2", Player.all.last.real_name)
      assert_equal("service tag 2", Player.all.last.service_tag)

   end
end
