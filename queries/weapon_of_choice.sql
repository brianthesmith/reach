SELECT      service_tag, weapons.name
FROM        weapons
INNER JOIN (
   SELECT      service_tag, 
               weapon_of_choice,
               count
   FROM (
      SELECT      service_tag, 
                  weapon_of_choice,
                  count(*) as count
      FROM        player_statistics
      GROUP BY    service_tag, 
                  weapon_of_choice
      ORDER BY    service_tag, 
                  count
   )
   GROUP BY service_tag
)
ON weapons.id = weapon_of_choice
