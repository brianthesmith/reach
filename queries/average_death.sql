SELECT      service_tag, 
            avg(deaths) as average_deaths 
FROM        player_statistics 
GROUP BY    service_tag
ORDER BY    average_deaths
