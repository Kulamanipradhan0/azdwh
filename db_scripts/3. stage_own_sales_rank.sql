drop table if exists stage_own.sales_rank;

create table stage_own.sales_rank(
asin	character varying(100),
category_name	character varying,
rank	numeric
--CONSTRAINT sales_rank_pkey PRIMARY KEY (asin,category_name)
);
