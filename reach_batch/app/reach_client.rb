require "rubygems"
require "json"
require "halo-reach-api"
require "active_record"

require "reach_logging"
require "reach_game"
require "reach_player"
require "reach_team"
require "reach_weapon_carnage_report"

class ReachClient
   ACCOUNT_1 ="Buckethead Died"
   ACCOUNT_2 = "jaymz9mm"
   CUSTOM_GAME = 6

   def initialize(reach = Halo::Reach::API.new(ApiKeyProvider.new.api_key), throttle = 0.5)
      @reach = reach
      @throttle = throttle
   end

   def most_recent_games
      json_games = games_on_page(0)
      populate_game_ids(json_games)
   end

   def all_historic_games
      json_games = []
      (0..24).each do |page|
         json_games = json_games | games_on_page(page)
      end

      populate_game_ids(json_games)
   end

   def populate_details(games)
      total_games = games.length
      current_game = 0
      games.each do |game|
         sleep(@throttle)
         current_game += 1
         LOG.info " - processing #{current_game} out of #{total_games}"
         game_details_json = @reach.get_game_details(game.id)["GameDetails"]

         game.base_map = game_details_json["BaseMapName"]
         game.duration = game_details_json["GameDuration"]
         game.timestamp = parse_timestamp(game_details_json["GameTimestamp"])
         game.variant_class = game_details_json["GameVariantClass"]
         game.map = game_details_json["MapName"]
         game.player_count = game_details_json["PlayerCount"]
         game.players = parse_players(game_details_json["Players"])
         if (game_details_json["Teams"] != nil)
            game.teams = parse_teams(game_details_json["Teams"])
         end
      end

      games
   end

   private
   def parse_players(json_players)
      players = []

      json_players.each do |json_player|
         player = ReachPlayer.new
         players << player

         player.assists = json_player["Assists"]
         player.average_death_distance = json_player["AvgDeathDistanceMeters"]
         player.average_kill_distance = json_player["AvgKillDistanceMeters"]
         player.betrayals = json_player["Betrayals"]
         player.did_not_finish = json_player["DNF"]
         player.assists = json_player["Assists"]
         player.deaths = json_player["Deaths"]
         player.head_shots = json_player["Headshots"]
         player.overall_standing = json_player["IndividualStandingWithNoRegardForTeams"]
         player.kills = json_player["Kills"]
         player.multi_kill_medals = json_player["MultiMedalCount"]
         player.other_medals = json_player["OtherMedalCount"]
         player.service_tag = json_player["PlayerDetail"]["service_tag"]
         player.emblem = json_player["PlayerDetail"]["ReachEmblem"]
         player.team_id = json_player["Team"]
         player.total_medals = json_player["TotalMedalCount"]
         player.weapon_carnage = parse_weapon_carnage(json_player["WeaponCarnageReport"])
      end

      players
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

   def parse_teams(json_teams)
      teams = []
      json_teams.each do |json_team|
         team = ReachTeam.new
         teams << team

         team.id = json_team["Index"]
         team.standing = json_team["Standing"]
         team.score = json_team["Score"]
         team.kills = json_team["TeamTotalKills"]
         team.assists = json_team["TeamTotalAsssists"]
         team.betrayals = json_team["TeamTotalBetrayals"]
         team.suicides = json_team["TeamTotalSuicides"]
         team.medals = json_team["TeamTotalMedals"]
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
