SELECT      service_tag, 
            (avg(kills) - avg(deaths)) as spread 
FROM        player_statistics
GROUP BY    service_tag
ORDER BY    spread
