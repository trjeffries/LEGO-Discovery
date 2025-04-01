-- Seeing how the number of minifigs in each collectible series has changed over time.
SELECT
	COUNT (DISTINCT sets.set_num) AS "Count"
	, themes.name
	, sets.year
FROM sets
INNER JOIN themes ON themes.id=sets.theme_id
WHERE themes.name LIKE '%Series%'
GROUP BY themes.id
ORDER BY "Count" DESC

--Seeing how part variance of sets has changed over time.
WITH set_values AS
(SELECT
	year
	, sets.set_num
	, name
	, num_parts
	, COUNT (DISTINCT part_num)
	, COUNT (DISTINCT part_num)/num_parts::numeric(9,5) as Uniqueness
FROM sets
INNER JOIN inventories ON inventories.set_num=sets.set_num
INNER JOIN inventory_parts ON inventories.id=inventory_parts.inventory_id
GROUP BY sets.set_num)

SELECT
	year
	, avg(Uniqueness)
FROM set_values
GROUP BY year
ORDER BY year

--Identifying the average part colour
SELECT
	1
	, TO_HEX(AVG(('0x'||left(rgb,2))::numeric)::int)
	, TO_HEX(AVG(('0x'||right(left(rgb, 4),2))::numeric)::int)
	, TO_HEX(AVG(('0x'||right(rgb,2))::numeric)::int)
FROM colors
GROUP BY 1