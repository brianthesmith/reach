class KillDeathSpreadModel
   def self.average_stats
      sql = "  select      service_tag, 
                           avg(kills) as kills, 
                           avg(deaths) as deaths,
                           avg(spread) as spread
               FROM        kill_death_spreads
               GROUP BY    service_tag
               ORDER BY    spread DESC
            "

      kill_death_spread_stats = []
      KillDeathSpread.find_by_sql(sql).each do |row|
         kill_death_spread_stat = KillDeathSpreadStat.new
         kill_death_spread_stat.service_tag = row.service_tag
         kill_death_spread_stat.kills = row.kills
         kill_death_spread_stat.deaths = row.deaths
         kill_death_spread_stat.spread = row.spread

         kill_death_spread_stats << kill_death_spread_stat
      end

      kill_death_spread_stats
   end
end
