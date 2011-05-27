class PlayerEffectivenessModel
   def self.stats_for_all_maps
      sql = "  SELECT         service_tag,
                              map,
                              avg((1.0 * team_score) / ((1.0 * team_size) / (1.0 * other_team_size))) as effectiveness
               FROM           player_effectivenesses 
               WHERE          map = 'Breakpoint'
               GROUP BY       service_tag
               ORDER By       effectiveness DESC
            "

      player_effectiveness_stats = []
      PlayerEffectiveness.find_by_sql(sql).each do |row|
         player_effectiveness_stat = PlayerEffectivenessStat.new
         player_effectiveness_stat.service_tag = row.service_tag
         player_effectiveness_stat.map = row.map
         player_effectiveness_stat.effectiveness = row.effectiveness

         player_effectiveness_stats << player_effectiveness_stat
      end
      player_effectiveness_stats
   end
end
