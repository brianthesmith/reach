require "test/unit"
require "json"
require "mocha"

require "meta_data_parser"
require "test_connection_info"

class MetaDataParserTest < Test::Unit::TestCase
   def setup
      @test_object = MetaDataParser.new("resources/game_meta_data.txt")

      Weapon.delete_all
   end

   def teardown
      Weapon.delete_all   
   end

   def test_all_weapons_are_pulled_from_file
      @test_object.all_weapons

      unknown_weapon = Weapon.where("name = ?", "Unknown Event")
      assert_not_nil(unknown_weapon.name)

      dmr_weapon = Weapon.where("name like ?", "DMR%")
      assert_equal("Although it saw more widespread use throughout all branches of the UNSC prior to 2548, it has since been superseded in use by the BR55 in all branches but the Army.", dmr_weapon[0].description)
   end
end
