class KillDeathSpreadProcessor
   def process_game(game)
      game.reach_teams.each do |team|
         team.reach_player_stats.each do |player_stat|
            kill_death_spread = KillDeathSpread.new
            kill_death_spread.player = player_stat.player
            kill_death_spread.kills = player_stat.kills
            kill_death_spread.deaths = player_stat.deaths
            kill_death_spread.spread = player_stat.kills - player_stat.deaths

            kill_death_spread.save
         end
      end
   end
end
