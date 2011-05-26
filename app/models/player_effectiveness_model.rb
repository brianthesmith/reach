class PlayerEffectivenessModel
   def self.stats_for_all_maps
      player_effectiveness_stats = []
      PlayerEffectiveness.all.each do |player_effectiveness|
         player_effectiveness_stat = PlayerEffectivenessStat.new
         player_effectiveness_stat.service_tag = player_effectiveness.service_tag
         player_effectiveness_stat.map = player_effectiveness.map
         player_effectiveness_stat.effectiveness = 0
      end
   end
end
