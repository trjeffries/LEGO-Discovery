-- Enable inventory_parts-parts relationship
INSERT INTO parts (
	SELECT DISTINCT
		IP.part_num,
		NULL as name,
		CAST(NULL as smallint) as part_cat_id
		FROM LEGO.inventory_parts as IP
	LEFT JOIN LEGO.parts as P ON IP.part_num = P.part_num
	WHERE P.part_num IS NULL
);

-- Add primary keys
ALTER TABLE LEGO.colors ADD PRIMARY KEY (id);
ALTER TABLE LEGO.inventories ADD PRIMARY KEY (id);
ALTER TABLE LEGO.parts ADD PRIMARY KEY (part_num);
ALTER TABLE LEGO.part_categories ADD PRIMARY KEY (id);
ALTER TABLE LEGO.sets ADD PRIMARY KEY (set_num);
ALTER TABLE LEGO.themes ADD PRIMARY KEY (id);

-- Add foreign keys
ALTER TABLE LEGO.parts ADD FOREIGN KEY (part_cat_id) 
	REFERENCES LEGO.part_categories(id);

ALTER TABLE LEGO.inventory_parts ADD FOREIGN KEY (inventory_id) 
	REFERENCES LEGO.inventories(id);
ALTER TABLE LEGO.inventory_parts ADD FOREIGN KEY (part_num) 
	REFERENCES LEGO.parts(part_num);
ALTER TABLE LEGO.inventory_parts ADD FOREIGN KEY (color_id) 
	REFERENCES LEGO.colors(id);

ALTER TABLE LEGO.inventory_sets ADD FOREIGN KEY (inventory_id) 
	REFERENCES LEGO.inventories(id);
ALTER TABLE LEGO.inventory_sets ADD FOREIGN KEY (set_num) 
	REFERENCES LEGO.sets(set_num);

ALTER TABLE LEGO.sets ADD FOREIGN KEY (theme_id) 
	REFERENCES LEGO.themes(id);

ALTER TABLE LEGO.inventories ADD FOREIGN KEY (set_num) 
	REFERENCES LEGO.sets(set_num);