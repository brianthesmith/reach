class PlayerEffectivenessProcessor
   def process_game(game)
      game.reach_teams.each do |team|
         team.reach_player_stats.each do |player_stat|
            player_effectiveness = PlayerEffectiveness.new
            player_effectiveness.player = player_stat.player
            player_effectiveness.map = game.map
            player_effectiveness.team_score = team_score(game, team.team_id)
            player_effectiveness.team_size = team_size(game, team.team_id)
            player_effectiveness.other_team_score = other_team_score(game, team.team_id)
            player_effectiveness.other_team_size = other_team_size(game, team.team_id)

            player_effectiveness.save
         end
      end
   end

   private 
   def team_score(game, team_id)
      score = 0

      game.reach_teams.each do |team|
         if team.team_id == team_id
            score = team.score
            break
         end
      end

      score
   end

   def team_size(game, team_id)
      team_size = 0

      game.reach_teams.each do |team|
         if team.team_id == team_id
            team_size = team.reach_player_stats.count
            break
         end
      end

      team_size
   end

   def other_team_score(game, team_id)
      score = 0

      game.reach_teams.each do |team|
         if team.team_id != team_id
            score += team.score
            break
         end
      end

      score
   end

   def other_team_size(game, team_id)
      team_size = 0

      game.reach_teams.each do |team|
         if team.team_id != team_id
            team_size += team.reach_player_stats.count
            break
         end
      end

      team_size
   end
end
