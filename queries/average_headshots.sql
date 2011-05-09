SELECT      service_tag, 
            avg(total_head_shots) as head_shots
FROM        player_statistics 
GROUP BY    service_tag
ORDER BY    head_shots
