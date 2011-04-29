require "test/unit"
require "mocha"

require "statistics_extracter"

class StatisticsExtracterTest < Test::Unit::TestCase
   def setup
      known_service_tags = ["tag_1", "tag_2", "tag_3"]

      @test_object = StatisticsExtracter.new(known_service_tags)

      @timestamp = Time.now
   end

   def create_mock_game()
      weapon_carnage1a = mock()
      weapon_carnage1a.stubs(:weapon_id => 0, :kills => 2, :deaths => 1, :head_shots => 2)
      weapon_carnage1b = mock()
      weapon_carnage1b.stubs(:weapon_id => 1, :kills => 7, :deaths => 3, :head_shots => 3)
      weapon_carnage1c = mock()
      weapon_carnage1c.stubs(:weapon_id => 2, :kills => 1, :deaths => 1, :head_shots => 1)

      weapon_carnage2a = mock()
      weapon_carnage2a.stubs(:weapon_id => 0, :kills => 1, :deaths => 2, :head_shots => 1)
      weapon_carnage2b = mock()
      weapon_carnage2b.stubs(:weapon_id => 1, :kills => 3, :deaths => 7, :head_shots => 1)
      weapon_carnage2c = mock()
      weapon_carnage2c.stubs(:weapon_id => 2, :kills => 1, :deaths => 1, :head_shots => 0)

      weapon_carnage1 = [weapon_carnage1a, weapon_carnage1b, weapon_carnage1c]
      weapon_carnage2 = [weapon_carnage2a, weapon_carnage2b, weapon_carnage2c]

      mock_player1 = mock()
      mock_player1.stubs(:service_tag => "tag_1", :kills => 10, :deaths => 5, :assists => 3, :total_medals => 4, :team_id => 0, :weapon_carnage => weapon_carnage1)

      mock_player2 = mock()
      mock_player2.stubs(:service_tag => "tag_2", :kills => 5, :deaths => 10, :assists => 0, :total_medals => 2, :team_id => 1, :weapon_carnage => weapon_carnage2)

      players = [mock_player1, mock_player2]

      team1 = mock()
      team1.stubs(:standing => 0)
      team2 = mock()
      team2.stubs(:standing => 1)

      teams = [team1, team2]

      mock_game = mock()
      mock_game.stubs(:id => 123, :variant_class => "slayer", :timestamp => @timestamp, :players => players, :teams => teams)

      mock_game
   end

   def test_only_create_statistics_for_known_service_tags
      player_stats = @test_object.extract_statistics(create_mock_game)

      assert_equal(2, player_stats.length)

      player1_stats = player_stats[0]

      assert_equal(123, player1_stats.reach_game_id)
      assert_equal("tag_1", player1_stats.service_tag)
      assert_equal("slayer", player1_stats.game_type)
      assert_equal(@timestamp, player1_stats.game_time)
      assert_equal(10, player1_stats.kills)
      assert_equal(5, player1_stats.deaths)
      assert_equal(3, player1_stats.assists)
      assert_equal(4, player1_stats.total_medals)
      assert(player1_stats.on_winning_team)
#      assert_equal(1, player1_stats.weapon_of_choice)
#      assert_equal(1, player1_stats.weapon_most_killed_by)
      assert_equal(6, player1_stats.total_head_shots)

      player2_stats = player_stats[1]

      assert_equal(123, player2_stats.reach_game_id)
      assert_equal("tag_2", player2_stats.service_tag)
      assert_equal("slayer", player2_stats.game_type)
      assert_equal(@timestamp, player2_stats.game_time)
      assert_equal(5, player2_stats.kills)
      assert_equal(10, player2_stats.deaths)
      assert_equal(0, player2_stats.assists)
      assert_equal(2, player2_stats.total_medals)
      assert(!player2_stats.on_winning_team)
#      assert_equal(1, player2_stats.weapon_of_choice)
#      assert_equal(1, player2_stats.weapon_most_killed_by)
      assert_equal(2, player2_stats.total_head_shots)
   end
end
