require "reach_logging"

class ReachJsonParser
   def initialize(data_directory = "reach_data")
      @data_directory = data_directory
   end

   def populate_details(game_ids)
      total_games = game_ids.length
      current_game = 0

      ignored_game_ids = []

      game_ids.each do |game_id|
         current_game += 1
         LOG.info " - reading in game #{current_game} out of #{total_games}"

         file_contents = JSON.parse(File.read("#{@data_directory}/#{game_id}.json"))
         game_details_json = file_contents["GameDetails"]

         if (game_details_json["Teams"] != nil)
            game = ReachGame.new
            game.reach_id = game_id
            game.name = game_details_json["GameVariantName"]
            game.duration = game_details_json["GameDuration"]
            game.timestamp = parse_timestamp(game_details_json["GameTimestamp"])
            
            map_name = game_details_json["MapName"]
            map = ReachMap.find_by_name(map_name)
            game.reach_map = map

            reach_teams = parse_teams(game, game_details_json["Teams"])

            parse_player_stats(reach_teams, game_details_json["Players"])

            game.save
         end
      end
   end

   private
   def parse_player_stats(reach_teams, json_players)
      json_players.each do |json_player|
         player_stat = ReachPlayerStat.new

         service_tag = json_player["PlayerDetail"]["service_tag"]
         player = Player.find_by_service_tag(service_tag)
         player_stat.player = player

         player_stat.assists = json_player["Assists"]
         player_stat.average_death_distance = json_player["AvgDeathDistanceMeters"]
         player_stat.average_kill_distance = json_player["AvgKillDistanceMeters"]
         player_stat.betrayals = json_player["Betrayals"]
         player_stat.did_not_finish = json_player["DNF"]
         player_stat.assists = json_player["Assists"]
         player_stat.deaths = json_player["Deaths"]
         player_stat.head_shots = json_player["Headshots"]
         player_stat.overall_standing = json_player["IndividualStandingWithNoRegardForTeams"]
         player_stat.kills = json_player["Kills"]
         player_stat.total_medals = json_player["TotalMedalCount"]

         # player_stat.multi_kill_medals = json_player["MultiMedalCount"]
         # player_stat.other_medals = json_player["OtherMedalCount"]
         # player_stat.emblem = json_player["PlayerDetail"]["ReachEmblem"]
         # player_stat.weapon_carnage = parse_weapon_carnage(json_player["WeaponCarnageReport"])

         reach_teams[json_player["Team"]].reach_player_stats << player_stat
      end
   end

   def parse_weapon_carnage(weapon_carnage_jsons)
      weapon_carnages = []
      weapon_carnage_jsons.each do |weapon_carnage_json|
         weapon_carnage = ReachWeaponCarnageReport.new
         weapon_carnages << weapon_carnage

         weapon_carnage.weapon_id = weapon_carnage_json["WeaponId"]
         weapon_carnage.deaths = weapon_carnage_json["Deaths"]
         weapon_carnage.head_shots = weapon_carnage_json["Headshots"]
         weapon_carnage.kills = weapon_carnage_json["Kills"]
         weapon_carnage.penalties = weapon_carnage_json["Penalties"]
      end

      weapon_carnages
   end

   def parse_teams(game, json_teams)
      teams = {}
      json_teams.each do |json_team|
         team = ReachTeam.new

         team_id = json_team["Index"]

         team.team_id = team_id
         team.standing = json_team["Standing"]
         team.score = json_team["Score"]
         team.kills = json_team["TeamTotalKills"]
         team.assists = json_team["TeamTotalAsssists"]
         team.betrayals = json_team["TeamTotalBetrayals"]
         team.suicides = json_team["TeamTotalSuicides"]
         team.medals = json_team["TeamTotalMedals"]

         game.reach_teams << team
         teams[team_id] = team
      end

      teams
   end

   def populate_game_ids(json_games)
      games = []
      json_games.each do |game_json|
         game = ReachGame.new
         game.id = game_json["GameId"]
         games << game
      end

      games.sort! do |game1, game2|
         game1.id <=> game2.id
      end

      games
   end

   def games_on_page(page_number)
      game_history1 = @reach.get_game_history(ACCOUNT_1, CUSTOM_GAME, page_number)["RecentGames"]
      game_history2 = @reach.get_game_history(ACCOUNT_2, CUSTOM_GAME, page_number)["RecentGames"]

      game_history1 | game_history2
   end

   def parse_timestamp(timestamp)
      if timestamp && (timestamp =~ /^\/Date\((\d+)-(\d+)\)\/$/)
         return [Time.at($1.to_i / 1000).utc, $2]
      else
         raise ArgumentError.new('Invalid timestamp') 
      end
   end
end
