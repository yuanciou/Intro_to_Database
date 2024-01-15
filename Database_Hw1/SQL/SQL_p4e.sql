WITH 
	quantity(color_name, inventory_id, quantity_sum) as(
	SELECT 
		colors.name, 
		inventory_parts.inventory_id, 
		sum (inventory_parts.quantity)
	FROM 
		inventory_parts join colors on colors.id = inventory_parts.color_id
	GROUP BY
		colors.name, inventory_parts.inventory_id, inventory_parts.part_num
	),
	total_quantity(themes_name, color_name, total_quantity, rank) as(
	SELECT 
		themes.name, 
		quantity.color_name, 
		sum(quantity.quantity_sum),
		rank() over (partition by themes.id 
					 order by sum(quantity.quantity_sum) desc) as rank
	FROM 
		themes join sets on themes.id = sets.theme_id 
		join inventories on sets.set_num = inventories.set_num
		join quantity on inventories.id = quantity.inventory_id
	GROUP BY 
		themes.id, 
		quantity.color_name
)
SELECT
	themes_name, 
	color_name
FROM 
	total_quantity
WHERE 
	rank = 1
ORDER BY 
	themes_name
