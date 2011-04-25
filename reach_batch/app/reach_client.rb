require "rubygems"
require "json"
require "halo-reach-api"

class ReachClient
   ACCOUNT_1 ="Buckethead Died"
   ACCOUNT_2 = "jaymz9mm"
   CUSTOM_GAME = 6

   def initialize(reach = Halo::Reach::API.new(ApiKeyProvider.new.api_key))
      @reach = reach
   end

   def most_recent_games
      json_games = games_on_page(0)
      parse_game_data(json_games)
   end

   def all_historic_games
      json_games = []
      (0..24).each do |page|
         json_games = json_games | games_on_page(page)
      end

      parse_game_data(json_games)
   end

   private
   def parse_game_data(json_games)
      games = populate_game_ids(json_games)
      populate_details(games)
      sort_by_id(games)
   end

   def populate_details(games)
      games.each do |game|
         game_details_json = @reach.get_game_details(ACCOUNT_1, CUSTOM_GAME, game.id)["GameDetails"]

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
   end

   def parse_players(json_players)
      players = []

      json_players.each do |json_player|
         player = Player.new
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
         player.total_medals = json_player["TotalMedalCount"]
         player.weapon_carnage = parse_weapon_carnage(json_player["WeaponCarnageReport"])
      end

      players
   end

   def parse_weapon_carnage(weapon_carnage_jsons)
      weapon_carnages = []
      weapon_carnage_jsons.each do |weapon_carnage_json|
         weapon_carnage = WeaponCarnageReport.new
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
         team = Team.new
         teams << team

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

   def sort_by_id(games)
      games.sort do |game1, game2|
         game1.id <=> game2.id
      end
   end

   def populate_game_ids(json_games)
      games = []
      json_games.each do |game_json|
         game = Game.new
         game.id = game_json["GameId"]
         games << game
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

   class Game
      attr_accessor :id
      attr_accessor :base_map
      attr_accessor :duration
      attr_accessor :timestamp
      attr_accessor :variant_class
      attr_accessor :map
      attr_accessor :player_count
      attr_accessor :players
      attr_accessor :teams
   end

   class Player
      attr_accessor :assists
      attr_accessor :average_death_distance
      attr_accessor :average_kill_distance
      attr_accessor :betrayals
      attr_accessor :did_not_finish
      attr_accessor :deaths
      attr_accessor :head_shots
      attr_accessor :overall_standing
      attr_accessor :kills
      attr_accessor :multi_kill_medals
      attr_accessor :other_medals
      attr_accessor :service_tag
      attr_accessor :emblem
      attr_accessor :total_medals
      attr_accessor :weapon_carnage
   end

   class WeaponCarnageReport
      attr_accessor :weapon_id
      attr_accessor :deaths
      attr_accessor :head_shots
      attr_accessor :kills
      attr_accessor :penalties
   end

   class Team
      attr_accessor :standing
      attr_accessor :score
      attr_accessor :kills
      attr_accessor :assists
      attr_accessor :betrayals
      attr_accessor :suicides
      attr_accessor :medals
   end
end
