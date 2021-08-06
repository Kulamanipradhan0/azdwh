drop table if exists stage_own.categories;

create table stage_own.categories(
category_name	character varying,
asin character varying(100),
category_rank character varying(4)
--CONSTRAINT categories_pkey PRIMARY KEY (category_name,asin)
);
