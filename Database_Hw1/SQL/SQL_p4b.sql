WITH 
    themes_count(name, num_set) as(
        SELECT 
			themes.name, 
			count(sets.name)
        FROM 
			sets, 
			themes
        WHERE 
			themes.id = sets.theme_id
        GROUP BY 
			themes.name)
SELECT 
    name, 
	num_set as max_set
FROM 
    themes_count
WHERE 
    num_set = (
        SELECT 
			MAX(num_set)
        FROM 
			themes_count
    );