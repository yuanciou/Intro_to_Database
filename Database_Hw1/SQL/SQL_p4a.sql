SELECT 
    sets.name as sets_name,
    themes.name as themes_name
FROM 
    sets,
    themes
WHERE 
    themes.id = sets.theme_id AND
    sets.year = 2017