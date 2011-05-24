class PlayerEffectivenessProcessor
   def process_game(game)
      game.players.each do |player|
         player_effectiveness = PlayerEffectiveness.new
         player_effectiveness.service_tag = player.service_tag
         player_effectiveness.map = game.base_map
         player_effectiveness.team_score = team_score(game, player.team_id)
         player_effectiveness.team_size = team_size(game, player.team_id)
         player_effectiveness.other_team_score = other_team_score(game, player.team_id)
         player_effectiveness.other_team_size = other_team_size(game, player.team_id)

         player_effectiveness.save
      end
   end

   private 
   def team_score(game, team_id)
      score = 0

      game.teams.each do |team|
         if team.id == team_id
            score = team.score
            break
         end
      end

      score
   end

   def team_size(game, team_id)
      team_size = 0

      game.players.each do |player|
         if player.team_id == team_id
            team_size += 1
         end
      end

      team_size
   end

   def other_team_score(game, team_id)
      score = 0

      game.teams.each do |team|
         if team.id != team_id
            score = team.score
            break
         end
      end

      score
   end

   def other_team_size(game, team_id)
      team_size = 0

      game.players.each do |player|
         if player.team_id != team_id
            team_size += 1
         end
      end

      team_size
   end
end
