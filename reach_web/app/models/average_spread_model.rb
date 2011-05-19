class AverageSpreadModel < PlayerStatBaseModel
   def self.average_spread
      sql = "  SELECT      service_tag, 
                           (avg(kills) - avg(deaths)) as value
               FROM        player_statistics
               GROUP BY    service_tag
               ORDER BY    value
            "

      player_stats(sql)
   end
end
