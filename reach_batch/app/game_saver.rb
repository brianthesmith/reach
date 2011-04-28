class PlayerStatistics
   def form_statistics(games)
      player_stats = []
      games.each do |game|
         game.players.each do |player|
            if is_player_we_care_about(player.service_tag)
               player_stat = PlayerStat.new
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
               player.weapon_carnage.sort! |x, y|
                  x.kills <=> y.kills
               end
               player_stat.weapon_of_choice = player.weapon_carnage[0].weapon_id
               player.weapon_carnage.sort! |x, y|
                  x.deaths <=> y.deaths
               end
               player_stat.weapon_most_killed_by = player.weapon_carnage[0].weapon_id
               total_head_shots = 0            
               player.weapon_carnage.each do |weapon_carnage_report|
                  total_head_shots += weapon_carnage_report.head_shots
               end
               player_stat.total_head_shots = total_head_shots
            end
         end
      end

      player_stats
   end

   private
   def is_player_we_care_about(questionable_service_tag)
      is_good = false
      known_service_tags.each do |good_service_tag|
         if questionable_service_tag == good_service_tag
            is_good = true
            break
         end
      end

      is_good
   end
end
