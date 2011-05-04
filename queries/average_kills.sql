SELECT      service_tag, 
            avg(kills) as average_kills
FROM        player_statistics 
GROUP BY    service_tag 
ORDER BY    average_kills
