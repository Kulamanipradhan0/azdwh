

drop table if exists dwh_own.xref_product_category CASCADE;

create table dwh_own.dim_category(
category_key	serial,
batch_identifier integer not null,
insert_datetime timestamp without time zone default current_timestamp,
last_update_datetime timestamp without time zone default current_timestamp,
category_name character varying(100),
price_bucket_key integer REFERENCEs dwh_own.dim_price_bucket,
CONSTRAINT dim_category_pkey PRIMARY KEY (category_key)
);

create index dim_category_ix_01 on dwh_own.dim_category (price_bucket_key,category_name);
