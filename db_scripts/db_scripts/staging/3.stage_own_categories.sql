drop table if exists stage_own.categories;

create table stage_own.categories(
batch_identifier integer not null,
category_name	character varying,
asin character varying(100),
category_rank character varying(4)
--CONSTRAINT categories_pkey PRIMARY KEY (category_name,asin)
);
