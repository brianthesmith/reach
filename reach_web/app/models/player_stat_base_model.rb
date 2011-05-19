class PlayerStatBaseModel
   def self.player_stats(sql)
      player_stats = []
      PlayerStatistic.find_by_sql(sql).each do |row|
         player_stat = PlayerStat.new
         player_stat.service_tag = row.service_tag
         player_stat.value = row.value
         player_stats << player_stat
      end

      player_stats
   end
end
