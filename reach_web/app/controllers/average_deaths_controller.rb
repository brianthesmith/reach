class AverageDeathsController < ActionController::Base
   layout "application"

   def index
      sql = "  SELECT      service_tag, 
                           avg(deaths) as average_deaths 
               FROM        player_statistics 
               GROUP BY    service_tag
               ORDER BY    average_deaths
            "

      @average_deaths = []
      PlayerStatistic.find_by_sql(sql).each do |row|
         average_death = AverageDeath.new
         average_death.service_tag = row.service_tag
         average_death.deaths = row.average_deaths
         @average_deaths << average_death
      end

   @title = "Average Deaths"
   end
end
