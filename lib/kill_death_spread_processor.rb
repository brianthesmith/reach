class KillDeathSpreadProcessor
   def process_game(game)
      game.players.each do |player|
         kill_death_spread = KillDeathSpread.new
         kill_death_spread.service_tag = player.service_tag         
         kill_death_spread.kills = player.kills
         kill_death_spread.deaths = player.deaths
         kill_death_spread.spread = player.kills - player.deaths

         kill_death_spread.save
      end
   end
end
