create table public.colors
(
	id varchar(20),
    name varchar(100),
    rgb char(6),
    is_trans boolean,
    primary key (id)
);

create table public.part_categories
(
    id varchar(20),
    name varchar(100),
    primary key (id)
);

create table themes
(
	id varchar(20),
    name varchar(100),
    parent_id varchar(15),
    primary key (id)
);

create table public.parts
(
    part_num varchar(20),
    name varchar(300),
    part_cat_id varchar(15),
    primary key (part_num),
    foreign key (part_cat_id) references part_categories(id)
);

create table sets
(
	set_num varchar(20),
    name varchar(100),
    year int,
    theme_id varchar(15),
    num_parts int,
    primary key (set_num),
    foreign key (theme_id) references themes(id)
);

create table public.inventories
(
	id varchar(20),
    version int,
    set_num varchar(20),
    primary key (id),
    foreign key (set_num) references sets(set_num)
);

create table public.inventory_parts
(
    inventory_id varchar(15),
    part_num varchar(20),
    color_id varchar(15),
    quantity int,
    is_spare boolean,
	/*no primary key*/
    foreign key (inventory_id) references inventories(id),
    foreign key (color_id) references colors(id)
);

create table public.inventory_sets
(
	inventory_id varchar(15),
    set_num varchar(20),
    quantity int,
    primary key (inventory_id, set_num),
    foreign key (inventory_id) references inventories(id),
    foreign key (set_num) references sets(set_num)
);

COPY public.colors(id, name, rgb, is_trans)
FROM 'C:\Program Files\PostgreSQL\15\bin\DB_Hw1_Datas\colors.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.part_categories(id, name)
FROM 'C:\Program Files\PostgreSQL\15\bin\DB_Hw1_Datas\part_categories.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.themes(id,name,parent_id)
FROM 'C:\Program Files\PostgreSQL\15\bin\DB_Hw1_Datas\themes.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.parts(part_num, name, part_cat_id)
FROM 'C:\Program Files\PostgreSQL\15\bin\DB_Hw1_Datas\parts.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.sets(set_num,name,year,theme_id,num_parts)
FROM 'C:\Program Files\PostgreSQL\15\bin\DB_Hw1_Datas\sets.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventories(id, version, set_num) 
FROM 'C:\Program Files\PostgreSQL\15\bin\DB_Hw1_Datas\inventories.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventory_parts(inventory_id, part_num, color_id, quantity, is_spare)
FROM 'C:\Program Files\PostgreSQL\15\bin\DB_Hw1_Datas\inventory_parts.csv'
DELIMITER ',' 
CSV HEADER;

COPY public.inventory_sets(inventory_id, set_num, quantity)
FROM 'C:\Program Files\PostgreSQL\15\bin\DB_Hw1_Datas\inventory_sets.csv'
DELIMITER ',' 
CSV HEADER;