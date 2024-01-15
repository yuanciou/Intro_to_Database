WITH 
    themes_avg(name, parts) as(
      SELECT 
		themes.name, avg(sets.num_parts)
      FROM 
		sets, themes
      WHERE 
		themes.id = sets.theme_id
      GROUP BY 
		themes.id)
SELECT 
    name, 
	parts as average_number_of_parts
FROM 
    themes_avg
ORDER BY
    average_number_of_parts asc