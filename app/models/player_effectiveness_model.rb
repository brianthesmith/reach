class PlayerEffectivenessModel
   def self.stats_for_map(map_name)
      sql = "  SELECT         p.real_name as player_name,
                              m.name as map,
                              avg((1.0 * team_score) / ((1.0 * team_size) / (1.0 * other_team_size))) as effectiveness
               FROM           player_effectivenesses pe, players p, reach_maps m
               WHERE          m.name = '#{map_name}'
               AND            m.id = pe.reach_map_id
               AND            pe.player_id = p.id
               GROUP BY       service_tag
               ORDER By       effectiveness DESC
            "

      player_effectiveness_stats = []
      PlayerEffectiveness.find_by_sql(sql).each do |row|
         player_effectiveness_stat = PlayerEffectivenessStat.new
         player_effectiveness_stat.player_name = row.player_name
         player_effectiveness_stat.map = row.map
         player_effectiveness_stat.effectiveness = row.effectiveness

         player_effectiveness_stats << player_effectiveness_stat
      end
      player_effectiveness_stats
   end
end
