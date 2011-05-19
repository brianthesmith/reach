class AverageDeathsModel < PlayerStatBaseModel
   def self.average_deaths
      sql = "  SELECT      service_tag, 
                           avg(deaths) as value 
               FROM        player_statistics 
               GROUP BY    service_tag
               ORDER BY    value
            "

      player_stats(sql)
   end
end
