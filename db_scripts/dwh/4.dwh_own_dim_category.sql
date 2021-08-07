

drop table if exists dwh_own.dim_category;

create table dwh_own.dim_category(
category_key	serial,
insert_datetime timestamp without time zone default current_timestamp,
category_name character varying(100),
price_bucket_id integer REFERENCEs dwh_own.dim_price_bucket,
CONSTRAINT dim_category_pkey PRIMARY KEY (category_key)
);
