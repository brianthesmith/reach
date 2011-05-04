SELECT      service_tag, 
            avg(total_medals) as medals 
FROM        player_statistics 
GROUP BY    service_tag
ORDER BY    medals
