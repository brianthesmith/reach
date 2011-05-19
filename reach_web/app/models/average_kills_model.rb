class AverageKillsModel < PlayerStatBaseModel
   def self.average_kills
      sql = "  SELECT      service_tag, 
                           avg(kills) as value
               FROM        player_statistics 
               GROUP BY    service_tag 
               ORDER BY    value
            "

      player_stats(sql)
   end
end
