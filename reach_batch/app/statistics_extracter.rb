require "player_statistic"

class StatisticsExtracter
   def initialize(known_service_tags)
      @known_service_tags = known_service_tags
   end

   def extract_statistics(game)
      player_stats = []
      game.players.each do |player|
         if is_known_player?(player.service_tag)
            player_stat = PlayerStatistic.new
            player_stats << player_stat

            player_stat.reach_game_id = game.id
            player_stat.service_tag = player.service_tag
            player_stat.game_type = game.variant_class
            player_stat.game_time = game.timestamp
            player_stat.kills =  player.kills
            player_stat.deaths =  player.deaths
            player_stat.assists =  player.assists
            player_stat.total_medals =  player.total_medals
            player_stat.on_winning_team =  game.teams[player.team_id].standing == 0

            weapon_carnage_reports = player.weapon_carnage
            weapon_carnage_reports.sort! do |x, y|
             (x.kills <=> y.kills)*-1
            end

            player_stat.weapon_of_choice = weapon_carnage_reports.first.weapon_id
            weapon_carnage_reports.sort! do |x, y|
               (x.deaths <=> y.deaths)*-1:
            end
            player_stat.weapon_most_killed_by = weapon_carnage_reports.first.weapon_id
            total_head_shots = 0            
            weapon_carnage_reports.each do |weapon_carnage_report|
               total_head_shots += weapon_carnage_report.head_shots
            end
            player_stat.total_head_shots = total_head_shots
         end
      end

      player_stats
   end

   private
   def is_known_player?(questionable_service_tag)
      is_good = false
      @known_service_tags.each do |good_service_tag|
         if questionable_service_tag == good_service_tag
            is_good = true
            break
         end
      end

      is_good
   end
end
